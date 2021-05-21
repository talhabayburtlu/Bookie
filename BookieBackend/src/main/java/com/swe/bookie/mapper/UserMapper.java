package com.swe.bookie.mapper;

import com.swe.bookie.entity.User;
import com.swe.bookie.lib.dto.UserDTO;
import com.swe.bookie.lib.resource.RestrictedUserResource;
import com.swe.bookie.lib.resource.UserResource;
import com.swe.bookie.service.abstracts.AddressService;
import com.swe.bookie.service.abstracts.UserService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class UserMapper {
    private final ModelMapper modelMapper = new ModelMapper();
    private final AddressService addressService;
    private final UserService userService;

    @Autowired
    public UserMapper(AddressService addressService, UserService userService) {
        this.addressService = addressService;
        this.userService = userService;
    }

    public User toEntity(UserDTO userDTO) { // Creates new user.
        User user = modelMapper.map(userDTO, User.class);
        user.setAddress(addressService.findById(userDTO.getAddressId()));
        user.setId(0);
        return user;
    }

    public User toEntity(UserDTO userDTO, User originalUser) { // Updates exist user.
        originalUser.setAge(userDTO.getAge());
        originalUser.setFullname(userDTO.getFullname());
        originalUser.setEmail(userDTO.getEmail());
        originalUser.setPassword(userDTO.getPassword());
        originalUser.setPhone(userDTO.getPhone());
        originalUser.setAddress(addressService.findById(userDTO.getAddressId()));
        return originalUser;
    }

    public UserResource toResource(User user) {
        UserResource userResource = modelMapper.map(user, UserResource.class);
        userResource.setCity(user.getAddress().getCity());
        userResource.setId(user.getId());
        return userResource;
    }

    public RestrictedUserResource toRestrictedResource(User user) {
        RestrictedUserResource restrictedUserResource = modelMapper.map(user, RestrictedUserResource.class);
        restrictedUserResource.setCity(user.getAddress().getCity());
        restrictedUserResource.setId(user.getId());
        return restrictedUserResource;
    }

}
