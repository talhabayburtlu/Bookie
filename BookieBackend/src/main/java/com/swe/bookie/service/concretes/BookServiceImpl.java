package com.swe.bookie.service.concretes;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.swe.bookie.dao.BookRepository;
import com.swe.bookie.entity.Book;
import com.swe.bookie.entity.User;
import com.swe.bookie.service.abstracts.BookService;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class BookServiceImpl implements BookService {
    private final String url = "https://www.googleapis.com/books/v1/volumes";

    @Autowired
    private BookRepository bookRepository;
    private final ObjectMapper objectMapper;

    public BookServiceImpl() {
        objectMapper = new ObjectMapper();
    }

    public Book getById(String id) {
        return bookRepository.getById(id);
    }

    public List<Book> getAllById(List<String> ids) {
        return bookRepository.getAllByIdIn(ids);
    }

    @Override
    public ArrayList<Book> searchForBooks(String title, User user) throws URISyntaxException, IOException {
        CloseableHttpClient httpclient = HttpClients.createDefault();

        URIBuilder builder = new URIBuilder(url)
                .setParameter("q", " intitle:" + title)
                .setParameter("printType", "books");

        HttpGet httpget = new HttpGet(builder.build().toString());
        HttpResponse httpresponse = httpclient.execute(httpget);

        Map<String, Object> response = objectMapper.readValue(httpresponse.getEntity().getContent(), Map.class);

        ArrayList<LinkedHashMap<String, Object>> items = (ArrayList<LinkedHashMap<String, Object>>) response.get("items");

        ArrayList<Book> books = items != null ? items.stream().map(item -> {
            Book book = extractBookFromInformation(item);

            boolean alreadyAdded = user.getPosts().stream().anyMatch(post -> {
                return post.getBookId().equals(book.getId());
            });

            return alreadyAdded ? null : book;
        }).collect(Collectors.toCollection(ArrayList::new)) : null;

        return books;
    }

    public Book createBook(String id) throws URISyntaxException, IOException { // Creates book
        CloseableHttpClient httpclient = HttpClients.createDefault();

        URIBuilder builder = new URIBuilder(url + "/" + id);

        HttpGet httpget = new HttpGet(builder.build().toString());
        HttpResponse httpresponse = httpclient.execute(httpget);

        Map<String, Object> response = objectMapper.readValue(httpresponse.getEntity().getContent(), Map.class);

        Book book = extractBookFromInformation(response);
        book.setId(id);
        return bookRepository.save(book);
    }

    private Book extractBookFromInformation(Map<String, Object> item) {
        // Retrieving book related information if exist.
        String id = (String) item.get("id");
        LinkedHashMap<String, Object> volumeInfo = (LinkedHashMap<String, Object>) item.get("volumeInfo");
        String returnedTitle = (String) volumeInfo.get("title");
        String returnedSubtitle = (String) volumeInfo.get("subtitle");
        String description = (String) volumeInfo.get("description");

        // Retrieving authors of book if exist.
        String author = null;
        ArrayList<String> authors = (ArrayList<String>) volumeInfo.get("authors");
        if (authors != null) {
            author = String.join(", ", authors);
        }

        // Retrieving isbn of book if exist.
        String isbn13 = null;
        ArrayList<LinkedHashMap<String, Object>> isbns = (ArrayList<LinkedHashMap<String, Object>>) volumeInfo.get("industryIdentifiers");
        if (isbns != null) {
            isbn13 = (String) isbns.get(0).get("identifier");
        }

        // Retrieving images of books if exist.
        String smallThumbnail = null, thumbnail = null;
        LinkedHashMap<String, Object> imageLinks = (LinkedHashMap<String, Object>) volumeInfo.get("imageLinks");
        if (imageLinks != null) {
            smallThumbnail = (String) imageLinks.get("smallThumbnail");
            thumbnail = (String) imageLinks.get("thumbnail");
        }

        // Returning books with retrieved information.
        return new Book(id, returnedTitle, returnedSubtitle, author, isbn13, smallThumbnail, thumbnail, description);
    }
}
