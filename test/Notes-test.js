const Notes = artifacts.require("Notes");

contract("Notes", accounts => {

    let instance;
    beforeEach("Note-test", async () => {
        instance = await Lottery.new();

    })

    it("Evaluar", async () =>{
        const res = await instance.Evaluar("AleG", 100, {from: accounts[0]})
        const student = web3.utils.keccak256("AleG")
        const note = await instance.VerNotas.call("AleG")
        assert.equal(student, res.logs[0].args[0])
        assert.equal(100,note)
    })

    it("Solo el profesor puede evaluar",async ()=>{
        try {
            await instance.Evaluar({from: accounts[6]});//hay que mancar desde que cuenta va gastar pq es de escritura/payable
            assert(false);
        } catch (e) {
            assert.equal("No tienes permisos para ejecutar esta funcion.", e.reason);//esta entrando al error
        }
    })

    //const riki=web3.utils.keccak256("AleG") console.log('RIKI',riki)



})