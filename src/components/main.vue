<template>
	<!-- App -->
	<div id="app">
		
		<!-- Statusbar -->
		<f7-statusbar></f7-statusbar>
		
		<!-- Main Views -->
		<f7-views>
			<f7-view id="main-view" navbar-through :dynamic-navbar="true" main>
				<!-- Navbar -->
				<f7-navbar>
					
					<f7-nav-center sliding>UPchieve Login</f7-nav-center>

				</f7-navbar>
				<!-- Pages -->
				<f7-pages>
					<f7-page>
            <f7-list>
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
              <f7-list-button title="Sign Up" link="/signup/"></f7-list-button>
            </f7-list>
					</f7-page>
				</f7-pages>
			</f7-view>
		</f7-views>
		
		<!-- Popup -->
		<f7-popup id="popup">
			<f7-view navbar-fixed>
				<f7-pages>
					<f7-page>
						<f7-navbar title="Popup">
							<f7-nav-right>
								<f7-link :close-popup="true">Close</f7-link>
							</f7-nav-right>
						</f7-navbar>
						<f7-block>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Neque, architecto. Cupiditate laudantium rem nesciunt numquam, ipsam. Voluptates omnis, a inventore atque ratione aliquam. Omnis iusto nemo quos ullam obcaecati, quod.</f7-block>
					</f7-page>
				</f7-pages>
			</f7-view>
		</f7-popup>
		
	</div>
</template>

<script>
    import AuthService from '../services/AuthService.js'

	export default {
	    data() {
	      let error;
	      // if (this.$route.query['401'] === 'true'){
	      //  error = 'Your session has expired. Please login again'
	      //}
	      return {
	        credentials: {
	          email: '',
	          password: ''
	        },
	        error: error
	      }
	    },
	    methods: {
	      submit() {
	        AuthService.login(this, {
	          email: this.credentials.email,
	          password: this.credentials.password
	        }, '/dashboard/')
	        // alert(this.credentials.email + " " + this.credentials.password)
	      }
	    }
    }
</script>
