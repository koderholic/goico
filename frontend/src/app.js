
import Vue from "vue"
import {router} from "@/routes"
import App from "./app.vue"

new Vue ({
  el: "#app",
  router,
  render: h => h(App)
})
