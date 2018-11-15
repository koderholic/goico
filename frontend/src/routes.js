import Vue from "vue"
import Router from "vue-router"

import indexComponent from "@/components/index"


Vue.use(Router)
export const router =  new Router({
    mode: "hash",
    routes: [
      { path: '', component: indexComponent },
      ]
    })
