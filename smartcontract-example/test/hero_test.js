const Hero = artifacts.require("Hero");
contract('Hero', (accounts) => {
    let hero
    before(async () => {
        hero = await Hero.deployed()
   
      })
    
      it('It should return Hulk', async () => {
        const receivedHero = await hero.getHero() 
        assert.equal(receivedHero, "Hulk")
      })

      it('It should set hero to Iron Man',async()=>{
          await hero.setHero("Iron Man",{from:accounts[0]})
          const receivedHero = await hero.getHero()
          assert.equal(receivedHero,"Iron Man")
      })
      
});
