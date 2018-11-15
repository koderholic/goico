<template>
  <div class="w-50 center pt4 ">
    <div class="fl w-100 br3 br--top bg-black-10 f7 ttu" style="color:#8ffef5">
      <div class="tracked pointer fl w-50 tc pv3 " :class="toggleProps.sendClass" @click="toggleTab('send')">
        SEND ETHER
      </div>
      <div class="tracked pointer fl w-50 tc pv3" :class="toggleProps.historyClass" @click="toggleTab('history')">
        HISTORY
      </div>
    </div>
    <div class="fl center w-100 tl bg-white ph3 br4 br--bottom primary">

      <div class="w-100 fl">
        <div class="dt center">
          <notify :notifications="notifications"></notify>
        </div>
      </div>
      
      
      <div v-if="toggleProps.sendShow" class="w-100 fl">
        <p class="fl tc f7 w-100"> 
          <img src="@/assets/logo.png" class="w4" /> 
        </p>
        <div class="fl w-100 dib items-center inline-flex primary bg-primary br2 tc pointer">
          <input type="number" class="bn f7 fl tracked bg-white-50 black pa2 w-100 primary bank-drop-search" placeholder="Amount in Ether e.g 0.0001" v-model.number="amount">
        </div>
        <div class="cf pv2 w-100"></div>
        <span @click="sendEther" class="right-0 fr br2 b ph3 pv2 black primary bg-primary pointer tracked f6">
            SEND ETHER
          </span>
        <div class="relative w-100 fl pv3 tc">
          <small>
            Send Ether to get DGT sent Back To You. <br/>
                **Please Make Sure to have Metamask**
          </small>
        </div>
      </div>

      <div v-if="toggleProps.historyShow" class="w-100 fl">
        <ul class="bg-white w-100 pa0 br3 br--bottom mt0 list fl overflow-scroll vh-50" style="">
          <li class="pa2 black-80 bb b--black-50" v-for="(transaction, index) in transactionList" :key="index">
            <span class="f7">#{{index+1}}</span> 

            <span class="w4 f7">{{transaction.Address}}</span>

            <span class="fr f7"  :class="{'bg-red white br2 pa1':transaction.Amount<0,'bg-green white br2 pa1':transaction.Amount>0}">
              {{transaction.Amount}}
            </span>
          </li>
        </ul>
      </div>


    </div>
  </div> 
</template>


<script type="text/javascript">
  import {HTTP} from '@/common';

  import notify from "@/components/common/notify"
  
  export default {
    created() {
      this.toggleTab("");
      const app = this;

      // HTTP.get("https://icanhazip.com/",{withCredentials: true}).then(response => {
      //   app.contact.IpAddress = response;
      //   app.contact.UserAgent = navigator.userAgent;
      // })
    },
    components: {notify},
    data() {return{
      notifications:[], status: "extract", sent:false,
      toggleProps:{}, amount:0.0001, address:'',
      transactionList:[
        {Address:"0xFc0bE3A3B33Bb9eFA0395FE827EF8ECD6859C202", Amount:-210},
        {Address:"0xFc0bE3A3B33Bb9eFA0395FE827EF8ECD6859C202", Amount:-30},
        {Address:"0xFc0bE3A3B33Bb9eFA0395FE827EF8ECD6859C202", Amount: 340},
        {Address:"0xFc0bE3A3B33Bb9eFA0395FE827EF8ECD6859C202", Amount: 130},
        {Address:"0xFc0bE3A3B33Bb9eFA0395FE827EF8ECD6859C202", Amount:-20},
        {Address:"0xFc0bE3A3B33Bb9eFA0395FE827EF8ECD6859C202", Amount:-120},
      ], 
    }},
    methods: {
      sendEther() {
        this.notifications.push({ Code:200, Message: "METAMASK WILL REQUIRE YOUR SIGNATURE" })
      },
      listTransactions(){

      },
      toggleTab(tabname) {
        this.notifications = []
        switch(tabname) {
          default:
            this.toggleProps = {sendClass:"b--white br3 br--top br--left bg-white primary",sendShow:true}
            break;
          case "history":
            this.toggleProps = {historyClass:"b--white br3 br--top br--right bg-white primary",historyShow:true}
            break;
        }
      },
    }
  }
</script>
