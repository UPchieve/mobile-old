<template>
  <f7-page login-screen no-navbar>
    <f7-login-screen-title>Login</f7-login-screen-title>
    <f7-list form>
      <f7-list-item>
        <f7-label>Email</f7-label>
        <f7-input name="username" type="text" placeholder="Email" required autofocus v-model="credentials.email"></f7-input>
      </f7-list-item>
      <f7-list-item>
        <f7-label>Password</f7-label>
        <f7-input name="password" type="password" placeholder="Password" required v-model="credentials.password"></f7-input>
      </f7-list-item>
    </f7-list>
    <f7-list>
      <f7-list-button title="Sign In" @click="submit"></f7-list-button>
    </f7-list>
  </f7-page>
</template>
<script>
  import AuthService from '../services/AuthService.js'

  export default {
    data() {
      // let error;
      // if (this.$route.query['401'] === 'true'){
      //  error = 'Your session has expired. Please login again'
      //}
      return {
        credentials: {
          email: '',
          password: ''
        },
        // error: error
      }
    },
    methods: {
      submit() {
        AuthService.login(this, {
          email: this.credentials.email,
          password: this.credentials.password
        }, '/home/')
        // alert(this.credentials.email + " " + this.credentials.password)
      }
    }
  }
</script>