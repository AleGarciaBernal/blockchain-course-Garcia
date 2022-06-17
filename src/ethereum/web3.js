import Web3 from "web3";

const isMetaMaskInstalled =() =>{

    const {ethereum}=window;
    return Boolean(ethereum&&ethereum.isMetaMask);
}

export const initialize=()=>{
    if(isMetaMaskInstalled()){
        window.web3=new Web3(window.ethereum);
    }else {
        alert("METAMASK IS NOT INSTALLED");
    }
}

export const connectWallet = async () =>{
    try{
        await window.ethereum.request({ method: "eth_requestAccounts"});
        alert("Wallet Connected")
    }catch (e){
        if(e.code === 401){
            alert("Connection Error")
        }else{
            alert(e.message)
        }
    }

}