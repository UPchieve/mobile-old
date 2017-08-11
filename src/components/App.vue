<template>
  <div id="app">
      <div class="nav-container">
        <sidebar></sidebar>
      </div>
      <div class="col-xs-12 view-container">
        <router-view></router-view>
      </div>
    </div>
</template>

<script>
import 'bootstrap/dist/css/bootstrap.css'


import AuthService from './services/AuthService';

AuthService.checkAuth();

export default {
  name: 'app',
  components: {
    Sidebar
  },
  created(){
    AuthService.checkAuth(this);
  }
}
</script>