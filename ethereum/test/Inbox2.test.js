const Inbox2= artifacts.require('Inbox2')

contract('Inbox2', accounts=>{

    it('getMessage',async () =>{

        const instance= await Inbox2.deployed();
        const message=await instance.getMessage.call();
        assert.equal(message,'hola')

    })

    it('setMessage solo el Owner',async () => {
        const instance=await Inbox2.deployed();
        await instance.setMessage('Hola',{from:accounts[0]});
        const message=await instance.getMessage.call();
        assert.equal(message,'Hola')

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
            assert.equal(e.reason,'Debe ser el owner para modificar')


        }

    });


})