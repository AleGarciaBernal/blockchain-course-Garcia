const TestBank= artifacts.require('TestBank');

contract("Bank-test", accounts => {

    let instance;

    beforeEach("UnitTest", async () => {
        instance = await TestBank.new();

    })

    //3) Realizar el testing solo el dueño puedo cerrar el banco

    it('Solo el owner puede cerrar banco ', async () => {
        await instance.closeOrOpenBank(true,{from:accounts[0]});

    });

    it("Only owner can close bank", async () => {
        try {
            await instance.closeOrOpenBank(true,{from: accounts[6]});
            //no podia hacer un create account por que no
            //avanzamos strcucts, Object values
            //como mandar un objeto y como instanciarlo
            assert(false);
        } catch (e) {
            assert.equal("You are not the owner.", e.reason);
            //no vimos ejemplos con varios modifiers
        }

    })

   // 4) Realizar el testing el deposito minimo para una cuenta bancaria debe ser mayor a 2 ETH
    it("require a minimum deposit of ether", async () => {
        try {
            await instance.depositMoney(2,{from: accounts[1], value: web3.utils.toWei("1", "ether")});
            assert(false);
        } catch (e) {
            console.log('ERROERRR',e.reason);
            assert.equal("The minimun deposit should be more than 2 ETH.", e.reason);
        }
    });

    //5) Realizar el testing el nombre de la cuenta debe tener una longitud mayor a 5 de forma obligatoria

    it('nombre deber ser mayor a 5 chars', async ()=>{
        //const juan=1,"Juan",10,true;
        const juan=await instance.createAccount(1,"Juan",10,true);//no acepta esto
        assert.equal(juan.nombre.length,5);
        //No se podia porque no avanzamos :(((


    })
    //6) Realizar el testing solo el dueño del banco puede bloquear una cuenta bancaria para que esta no pueda
    // realizar ningun tipo de transaccion de retiro ni deposito

    it('Only Owner Can Block', async () => {
        //const juan=instance.createAccount(1,"juan",100,true);
        //usar stucts :(
        const cuenta=await instance.listAccounts.call(1);
        await instance.blockAccount(1,{from:accounts[0]});
        assert.equal(cuenta.enable,false);

    });

    it('Only Owner Block Accounts', async () => {
        try {
            await instance.blockAccount(3,{from: accounts[6]});//hay que mancar desde que cuenta va gastar pq es de escritura/payable
            assert(false);
        } catch (e) {
            assert.equal("You are not the owner.", e.reason);//esta entrando al error
            //varios modifiers
        }

    })

    //8) Realizar el testing solo el dueño del banco puede retirar todos los fondos a su billetera digital, dejando al
    // banco sin fondos
/*
    it('Solo el owner puede retirar fondos', async () => {
        await instance.createAccount();
        const juan1=await listAccounts.call(1);
        await instance.withdrawAllMoney({from:accounts[0]});
        assert.equal(0,juan1.balance);

    });
  */
    it('Only Owner can retire the money', async () => {
        try {
            await instance.withdrawAllMoney({from: accounts[2]});//hay que mancar desde que cuenta va gastar pq es de escritura/payable
            assert(false);
        } catch (e) {
            assert.equal("You are not the owner.", e.reason);//esta entrando al error
        }
    })




})

