const Inbox2= artifacts.require('Inbox2')

contract('Inbox2', accounts=>{

    it('getMessage',async () =>{

        const instance= await Inbox2.deployed();
        const message=await instance.getMessage.call();
        assert.equal(message,'hola')

    })

    it('setMessage',async () => {
        const instance=await Inbox2.deployed();
        await instance.setMessage('Hola',{from:accounts[0]});
        const message=await instance.getMessage.call();
        assert.equal(message,'Hola')

    })


})