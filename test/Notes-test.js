const Notes = artifacts.require("Notes");

contract("Notes-test", accounts => {

    let instance;
    beforeEach("UnitTest", async () => {
        instance = await Lottery.new();

    })

    it("Evaluar Test", async () => {

        await instance.Evaluar("Ale G", 2,{from:accounts[5]});//la funcion pide parametros

        const id=await web.3.utils.keccak("Ale G")
        const note=await instance.Notas.call(id)

    })





})