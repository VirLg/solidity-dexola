# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.js
```


Після компеляції та деплою
є можливість:

купляти токени(можна переказати 1 Ether, за це отримати 100 токенів)
при оплаті кількість токенів зменьшується

Також є можливість додавати користувача в блек ліст. та виводити його за потреби.

Є можливість додавати токени за потреби.

Можна вивотити кошти на адресу того хто розміснив контракт

Для запуска через VS code 

npx hardhat node 