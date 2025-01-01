// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;


contract SimpleStorage {
    // bool hasNumber = true;
    // uint256 number = 29;
    // string favoriteNumber = "Five";

    uint256  favoriteNumber;
    
    mapping (string => uint256) public nameToFavoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    function store (uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve () public view returns(uint256) {
        return  favoriteNumber;
    }

    People[] public people;

    function addPerson (string memory _name, uint256 _favoriteNumber) public {
        people.push(People(_favoriteNumber, _name));

        // People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        // people.push(newPerson);
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}