package com.swe.bookie.service.concretes;

import com.swe.bookie.dao.AddressRepository;
import com.swe.bookie.entity.Address;
import com.swe.bookie.service.abstracts.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AddressServiceImpl implements AddressService {

    private final AddressRepository addressRepository;

    @Autowired
    public AddressServiceImpl(AddressRepository addressRepository) {
        this.addressRepository = addressRepository;
    }

    @Override
    public Address findById(int id) {
        return addressRepository.findById(id).orElseThrow(RuntimeException::new);
    }

}
