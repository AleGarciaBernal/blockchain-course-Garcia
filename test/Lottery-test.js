const Lottery = artifacts.require("Lottery");

contract("Lottery-test", accounts=>{

    let instance;

    beforeEach("UnitTest", async ()=>{
        instance= await Lottery.new();

    })

    it("enter an account", async ()=>{
        await instance.enter({from: accounts[1], value:web3.utils.toWei("3","ether")});//VERIFICA QUE ALGUIEN PUEDA APOSTAR
        const players=await instance.getPlayers.call();
        assert.equal(1,players.length)//queremo ver si ha entrado un jugador, que el array sea de tamaño 1
        assert.equal(accounts[1],players[0]);//comparando que sea la misma direccion de billeteras
    } )

    it("allow multiple players", async ()=> {
        await instance.enter({from: accounts[0], value:web3.utils.toWei("3","ether")});
        await instance.enter({from: accounts[1], value:web3.utils.toWei("3","ether")});
        await instance.enter({from: accounts[2], value:web3.utils.toWei("3","ether")});
        const players=await instance.getPlayers.call();
        assert.equal(accounts[0],players[0]);
        assert.equal(accounts[1],players[1]);
        assert.equal(accounts[2],players[2]);
        assert.equal(3,players.length) ///queremo ver si ha entrado un jugador, que el array sea de tamaño 3


    })
})

 //