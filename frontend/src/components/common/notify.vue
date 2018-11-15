<template>
  <div class="dt">
    <p v-for="(alert, index) in notifications" :key="index" v-if="alert.Message!==''" class="cf w-100 br1 pr2 f7 fw4 " :class="{'bg-primary primary':alert.Code==200,'bg-orange white':alert.Code!==200}">
        <span class="pointer fl w-auto pa1 bg-black-40 white fw6" @click="close(index)">&times;</span>
        <span class="fl w-auto pa1"> {{ alert.Message }} </span>
    </p>
  </div>
</template>
<script type="text/javascript">
  export default {
    props: ['notifications'],
    methods: {
      close(index) {
        this.$delete(this.notifications, index)
      }
    },
  }
</script>
