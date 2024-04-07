// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PaymentsToken{
address public owner;
uint256 public balance;

uint public tokenPrice;
uint public totalAmountTokens;
uint256 public DURATION;
uint amountToken;

struct Buyer{
 
  address byerAddress;
  uint amount;
  bool isBloked;
 uint timestamp;
}

struct ByToken{
    bool isBloked;
    uint totalPayments;
mapping (uint=>Buyer) buyers;
}
mapping (address => ByToken) public uniuqUser;

struct Black{
  address user;
  bool isBloked;
}

Black[]public blackList;

 constructor(){
        owner=msg.sender;
        totalAmountTokens= 100000000;
        tokenPrice = 10000000000000000;
 }
modifier saleAdmin(address _to){
  require(msg.sender==owner, "You are not Owner!");
  _;
}
modifier onlyOwner(address _to){
  require(msg.sender==owner, "You are not Owner!");
  require(_to!=address(0), "incorrect address");
  require(_to!=address(0), "incorrect address");
  _;
}

function CreateToken( uint _tokenAmount,address _to)external saleAdmin(_to)returns(uint){
if(totalAmountTokens==0){
  return totalAmountTokens;
}
  return totalAmountTokens=totalAmountTokens+_tokenAmount;
}

function getAmountUserToken(address _addr) public view returns (Buyer[] memory) {
uint paymentNum = uniuqUser[_addr].totalPayments;
Buyer[] memory buyersList = new Buyer[](paymentNum);
  for(uint i = 0; i < paymentNum; i += 1) {
      buyersList[i] = uniuqUser[_addr].buyers[i];
  }  
  return buyersList;
}

function withdrowAll(address payable _to)external onlyOwner(_to){   
  _to.transfer(address(this).balance);   
}
function blokedUser(address _blackUserAddress)public{
  Black memory black = Black(_blackUserAddress,true);
blackList.push(black);
}

 function isUserBlocked() public view returns (bool) {
        for (uint i = 0; i < blackList.length; i++) {
            if (blackList[i].user == msg.sender) {
                return true; // Користувач заблокований
            }
        }
        return false; // Користувач не заблокований
    }
function Pay( )public payable {
  require(!isUserBlocked(), "You are blocked from purchasing."); 

uint buyerNum = uniuqUser[msg.sender].totalPayments;
uniuqUser[msg.sender].totalPayments++;
Buyer memory newBuyer = Buyer(
  msg.sender,
  msg.value/tokenPrice,
  false,
  block.timestamp
);
uniuqUser[msg.sender].buyers[buyerNum]=newBuyer;
totalAmountTokens=totalAmountTokens- msg.value/tokenPrice;
balance+=msg.value;  

emit Paid(msg.sender,msg.value/tokenPrice,block.timestamp);
  

}

function unBlokedUser(address _to) public {
    for (uint i = 0; i < blackList.length; i++) {
        if (blackList[i].user == _to) {
            delete blackList[i]; 
        }
    }   
}



event Paid(address indexed _from, uint amount, uint _timestemp);

}


contract Chaild is PaymentsToken  {

struct SalesList{
        uint startAt;
        uint endAt;
        bool stopedSale;
        uint saleTokenPrice;
        uint saleTokenAmount;      
}
SalesList[] public saleceList;
event newSale(uint index, uint saleTokenPrice, uint duration);  
  function CreateTokenWhithSale(uint _duration, uint _saleTokenPrice,uint _saleTokenAmount,address _to) external    onlyOwner(_to) {
 uint duration =  _duration==0?DURATION:_duration;
  

    require(_saleTokenPrice!=0, "Invalid Discoutn Price");

SalesList memory newSaleList = SalesList({
  startAt:block.timestamp,
endAt:block.timestamp + duration,
stopedSale:false,
 saleTokenPrice:_saleTokenPrice,
  saleTokenAmount:_saleTokenAmount
});

saleceList.push(newSaleList);
emit newSale(saleceList.length-1,_saleTokenPrice,duration);
  }
  // function getElapseTime(uint index)public view returns (uint){
  //   SalesList memory currentSale = saleceList[index];
  //   require(!currentSale.stopped,"Stopped");
  //   uint elapse = block.timestamp-currentSale.startAt;
  //   return elapse;
  // }

}