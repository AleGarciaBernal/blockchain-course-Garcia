const Lottery = artifacts.require("Lottery");

contract("Lottery-test", accounts=>{

    it("enter an account", async ()=>{
        const instance=await Lottery.deployed();
        await instance.enter({from: accounts[1], value:web3.utils.toWei("3","ether")});//VERIFICA QUE ALGUIEN PUEDA APOSTAR

        const players=await instance.getPlayers.call();

        assert.equal(1,players.length)//queremo ver si ha entrado un jugador, que el array sea de tamaño 1
        assert.equal(accounts[1],players[0]);//comparando que sea la misma direccion de billeteras

    } )
})