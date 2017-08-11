<template>
	<f7-page>
		<f7-navbar title="Sign Up" back-link="Back" sliding></f7-navbar>
		<f7-list>
	      <f7-list-item>
	        <f7-label>E-mail</f7-label>
            <f7-input name="email" type="text" class="form-control" placeholder="E-mail Address" required autofocus v-model="credentials.email"></f7-input>
	      </f7-list-item>
	      <f7-list-item>
	        <f7-label>Password</f7-label>
            <f7-input name="email" type="password" class="form-control" placeholder="Password" required autofocus v-model="credentials.password"></f7-input>
	      </f7-list-item>
	      <f7-list>
              <f7-list-button title="Create Account" @click="submit"></f7-list-button>
            </f7-list>
	    </f7-list>
	</f7-page>
</template>

<script>

    import AuthService from 'src/services/AuthService'
    import RegistrationService from 'src/services/RegistrationService'

	export default {
	  data() {
	    return {
	      msg: '',
	      credentials: {
	        email: '',
	        password: ''
	      },
	      showingSuccess: false
	    }
	  },
	  methods: {
	    submit() {
	      AuthService.register(this, {
	        code: RegistrationService.data.registrationCode,
	        email: this.credentials.email,
	        password: this.credentials.password
	      }).then(() => {
	        this.showingSuccess = true;
	        alert("Your account is successfully created. Please check your email inbox for verification email.")
	      }).catch((err) => {
	        console.log(err);
	        alert(err.message)
	      })
	    }
      }
	}
</script>