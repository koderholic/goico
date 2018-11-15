<template>
  <section class="">


    <loading/>
    <div class="cf w-100 bg-blank vh-100 " style="background-image: url(assets/bg-top.png)">
      <navmenu/>

        <div class="dt w-100">
          <div class="dtc v-mid pb5 pt5-l">

            <div class="fl pa1 w-100 center">
                <div class="w-50 center bg-white ">
                  <notify :notifications="notifications"></notify>
                </div>

                <ctabox></ctabox>
            </div>    
            
          </div>
        </div>
    </div>
      
  </section>
</template>


<script type="text/javascript">
  import navmenu from "@/components/common/navmenu"
  import loading from "@/components/common/loading"
  
  import ctabox from "@/components/common/ctabox"

  import notify from "@/components/common/notify"
  
  export default {
    created() {
      
      const app = this
      window.addEventListener('load', function() {

        // Check if Web3 has been injected by the browser:
        if (typeof web3 !== 'undefined') {
          // You have a web3 browser! Continue below!
          // const eth = new Eth(web3.currentProvider)
          // const contract = new EthContract(eth)

          app.notifications.push({ Code:200, Message: "META MASK IS AVAILABLE" })
        } else {
          // Warn the user that they need to get a web3 browser
          // Or install MetaMask, maybe with a nice graphic.
          app.notifications.push({ Code:500, Message: "METAMASK WILL REQUIRE YOUR SIGNATURE" })
        }

      })

    },
    components: {
      navmenu, loading, ctabox,  notify
    },
    data() {return{ notifications:[]}},
    methods: {}
  }
</script>
