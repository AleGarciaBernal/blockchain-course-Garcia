const Inbox2= artifacts.require('Inbox2')

contract('Inbox2', accounts => { //nombre del testing

    it('getMessage',async () =>{ //testeando metodo getMessage
        const instance= await Inbox2.deployed(); //instancia del contract
        const message=await instance.getMessage.call(); //guardamos en una variable el mensaje
        //console.log(getMessage,message);
        assert.equal(message,'helloworld') //igualando con assert equal, migrations

    })

    it('setMessage solo el Owner',async () => {

        const instance=await Inbox2.deployed();//obtenemos la instancia
        await instance.setMessage('Hola',{from:accounts[0]}); //como es de escritura pasamos una wallet y variable de entrada
        const message=await instance.getMessage.call();//guardamo el mensaje con getMessage
        assert.equal(message,'Hola');//Comparamos

    })
/*
    it('setMessage Only The Owner Should Change the message',async () => {
        const instance=await Inbox2.deployed();
        await instance.setMessage('Hola',{from:accounts[0]});
        const message=await instance.getMessage.call();
        assert.equal(message,'Hola')

    })

 */

    it('setMessage should not change', async () => {
        try {
            const instance=await Inbox2.deployed();
            await instance.setMessage('Hola Bola',{from:accounts[1]});
            //const message=await instance.getMessage.call();
        }catch (e){
             //console.log('ERRORR',e)
             assert.equal(e.reason,'Debe ser el owner para modificar')//comparar con el smart contract


        }

    });


})