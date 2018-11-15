<template >
  <section>
    <header class="sans-serif fixed w-100 z-max">
      <nav class="dt w-100 center ph4-l " :class="menuBG"> 
        <div class="dt w-100 mw9 center right-0 left-0">
          <div class="dn dtc-l tl v-mid w-third-l pa3 primary b tracked">
            DIGINEX TOKEN ICO
          </div>
                    

          <div class="dtc tr v-mid w-70 w-third-l pa3">
            <a class="f6 hover-black no-underline primary pv2 ph1 dn dib-ns" href="/" >
              <span class="pv2 ph3 bg-white-50 br2">Log in</span>
            </a>
            <span class="f7 fw2 dn dib-ns">or</span>
            <a class="f6 hover-black no-underline primary pv2 ph1" href="/" >
              <span class="pv2 ph3 bg-white-50 br2">Sign Up</span>
            </a> 
          </div>
        </div>
      </nav>
    </header>
    <header class="h3 w-100 fl"></header>
    
  </section>
</template>

<!-- App specific objects  -->
<script type="text/javascript">
  
  export default {
    components: {}, 
    data() {return{
      lShow:false, slideOut:"dn",
      menuBG:"",
    }},
    methods: {
      toggleMenu() {
        this.lShow = !this.lShow
        document.getElementsByTagName("html")[0].classList.toggle('overflow-hidden');
      },
      toggleMenuBG() {
        var menuBG;
        var shrinkOn = window.outerHeight/2.5;
        var distanceY = window.pageYOffset || document.documentElement.scrollTop;
        if (distanceY > shrinkOn) {
          menuBG = "bg-white-90";
        } else {
          menuBG = "";
        }

        if (menuBG !== this.menuBG) {
          this.menuBG = menuBG
        }
      },
    },
    created(){
      window.addEventListener('scroll', this.toggleMenuBG);
    },
    destroyed(){
      document.removeEventListener("scroll", this.toggleMenuBG)
    }
  }
</script>