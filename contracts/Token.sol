//ERC721’s as non-fungible tokens that can hold metadata
//a proposed* standard that would allow smart contracts to operate as tradeable
//tokens similar to ERC20. ERC721 tokens are unique in that the tokens are non-fungible.

pragma solidity ^0.4.17;


contract Token {

  uint256 constant private totalTokens = 1000;  //might need array
  mapping(address => uint) private balances;
  mapping(uint256 => address) private tokenOwners;
  mapping(address => mapping (address => uint256)) allowed;
  mapping(uint256 => bool) private tokenExists;
  mapping(uint256 => string) tokenData;



 constructor() public {
   uint256 tokenId = 1;
   address owner = 0xa14383847701e86bd9a9d12b55add2c34fac3b05;

   balances[owner] = 1;
   tokenExists[tokenId] = true;
   tokenOwners[tokenId] = owner;

 }

  //declare total number of token available
  function totalSupply() constant returns(uint256 totalTokens){
    return totalTokens;
  }


  //find out number of token in x account
  function balanceOf(address _owner) constant returns (uint balance) {
    return balances[_owner];
  }


  //OWNERSHIP
  //returns address of token owner, verify ownership of a certain token index
  //mapping(uint256 => bool) private tokenExists;
  function ownerOf(uint256 _tokenId) returns (address owner){
    return tokenOwners[_tokenId];
  }

  function takeOwnership(uint256 _tokenId){
    require(tokenExists[_tokenId]);
    address currentOwner = ownerOf(_tokenId);
    address newOwner = msg.sender;
    require(newOwner != currentOwner);
    tokenOwners[_tokenId] = newOwner;
    Transfer(currentOwner, newOwner, _tokenId);
  }



  //approve function
  function approve(address _to, uint256 _tokenId) {
    require(msg.sender == ownerOf(_tokenId));
    require(msg.sender != _to);
    allowed[msg.sender][_to] = _tokenId;
    Approval(msg.sender, _to, _tokenId);
  }


  //transfer function
  function transfer(address _to, uint256 _tokenId) {
    address currentOwner = msg.sender;
    address newOwner = _to;

    require(tokenExists[_tokenId]);
    require(currentOwner == ownerOf(_tokenId));
    require(currentOwner != newOwner);

    tokenOwners[_tokenId]=newOwner;
    Transfer(currentOwner, newOwner, _tokenId);

  }

  //TODOS
  //discover METADATA STORED IN TOKEN - can store course information etc
  function tokenMetadata(uint256 _tokenId) constant returns (string infoUrl){
    return tokenData[_tokenId];
  }


  //transfer
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);

  //approval from 1 authority/ identified by address --
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);


  //TODOS
  //automatic transfer?
  //create tokens only by 1 authority

  /*
  function createToken(uint256_genes) external onlyAuthority {
  uint256 tokenId = _createToken(0,0,0, _genes, address(this));
  tokenCreatedCount ++;

}


function getToken(uint256_id) external view returns {
uint256 creationTime,
uint256 variants
}
*/


}
