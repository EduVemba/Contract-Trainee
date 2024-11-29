// SPDX-License-Indentifier: MIT

pragma solidity ^0.8.8;


contract SimpleStorage {

    uint256 public favoriteNumber;

    mapping (string => uint256) public nameToFavoriteNumber;



    struct People {
        uint256 favoriteNumber;
        string name;
    }


    People[] public population;


    function store(uint256 newFavoriteNumber) public virtual  {
        favoriteNumber = newFavoriteNumber;
      //  uint256 testVar = 5;
    }

    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

    // calldata, memory, storage
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        population.push(People(_favoriteNumber,_name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}


// 0xd9145CCE52D386f254917e481eB44e9943F39138