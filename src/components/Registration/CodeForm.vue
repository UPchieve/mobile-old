<template>
	<f7-page>
		<f7-navbar title="Sign Up" back-link="Back" sliding></f7-navbar>
		<f7-list>
	      <f7-list-item>
	        <f7-label>Code</f7-label>
            <f7-input name="regcode" type="text" class="form-control" placeholder="Registration Code" required autofocus v-model="registrationCode"></f7-input>
	      </f7-list-item>
	      <f7-list>
              <f7-list-button title="Continue" @click="submit"></f7-list-button>
            </f7-list>
	    </f7-list>
	</f7-page>
</template>

<script>

    import RegistrationService from 'src/services/RegistrationService'

	export default {
	  data() {
	    return {
	      registrationCode: '',
	      msg: ''
	    }
	  },
	  methods: {
	    submit() {
	      RegistrationService.checkCode(this, this.registrationCode)
	        .then((isValid) => {
	          if (!isValid){
	            // this.msg = 'Sorry, that code is invalid';
	            alert('Sorry, that code is invalid')
	          }
	        })
	    }
	  }
	}
</script>