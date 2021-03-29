package com.swe.bookie.mapper;

import com.swe.bookie.entity.User;
import com.swe.bookie.lib.dto.RegisterDTO;
import com.swe.bookie.lib.resource.RegisterResource;
import com.swe.bookie.service.AddressService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class RegisterMapper {
    private final ModelMapper modelMapper = new ModelMapper();
    private final AddressService addressService;

    @Autowired
    public RegisterMapper(AddressService addressService) {
        this.addressService = addressService;
    }

    public User toEntity(RegisterDTO registerDTO) {
        User user = modelMapper.map(registerDTO, User.class);
        user.setAddress(addressService.findById(registerDTO.getAddressId()));
        return user;
    }

    public RegisterResource toResource(User user) {
        RegisterResource registerResource = modelMapper.map(user, RegisterResource.class);
        registerResource.setCity(user.getAddress().getCity());
        return registerResource;
    }

}
