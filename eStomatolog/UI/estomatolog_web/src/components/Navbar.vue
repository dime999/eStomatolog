<template>
  <nav class="navbar">
    <div class="navbar-container">
      <router-link v-if="!isMobile" to="/" class="navbar-logo"> <span class="logo-icon"></span> eStomatolog</router-link>
      <div v-if="isMobile" class="mobile-menu">
        <div class="navbar-toggle-container">
          <button class="navbar-toggle" @click="toggleMenu" :class="{ 'open': isMobileMenuOpen }">
            <span class="bar"></span>
            <span class="bar"></span>
            <span class="bar"></span>
          </button>
        </div>
        <div class="mobile">
          <ul class="navbar-menu" :class="{ 'navbar-menu-open': isMobileMenuOpen }">
            <li class="margin-element"><router-link to="/" class="navbar-link" @click="isMobileMenuOpen = false">Početna</router-link></li>
            <li class="margin-element"><router-link to="/about" class="navbar-link" @click="isMobileMenuOpen = false">O nama</router-link></li>
            <li class="margin-element"><router-link to="/contact" class="navbar-link" @click="isMobileMenuOpen = false">Kontakt</router-link></li>
          </ul>
        </div>
      </div>
      <div class="desktop">
        <ul v-if="!isMobile" class="navbar-desktop-menu">
          <li><router-link to="/" class="navbar-link-desktop">Početna</router-link></li>
          <li><router-link to="/about" class="navbar-link-desktop">O nama</router-link></li>
          <li><router-link to="/contact" class="navbar-link-desktop">Kontakt</router-link></li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  name: 'AppNavbar',
  data() {
    return {
      isMobileMenuOpen: false,
      isMobile: false
    };
  },
  mounted() {
    this.checkWindowSize();
    window.addEventListener('resize', this.checkWindowSize);
  },
  beforeUnmount() {
    window.removeEventListener('resize', this.checkWindowSize);
  },
  methods: {
    toggleMenu() {
      this.isMobileMenuOpen = !this.isMobileMenuOpen;
    },
    checkWindowSize() {
      this.isMobile = window.innerWidth <= 768;
    }
  }
};
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap');

* {
  font-family: 'Roboto', sans-serif;
}

li {
  color: #333; 
  font-weight: bold; 
}

.navbar {
  background-color: rgba(0, 123, 255, 0.571); 
  color: white;
  font-family: Arial, sans-serif;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  z-index: 1000;
}


.navbar-container {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
}

.navbar-logo {
  font-size: 1.5rem;
  text-decoration: none;
  color: white;
}

.mobile-menu {
  display: flex;
  align-items: center;
}

.navbar-menu,
.navbar-desktop-menu {
  list-style-type: none;
  padding: 0;
  text-align: center;
  margin: 10px 0; 
}

.desktop {
  display: flex;
  justify-content: center; 
  align-items: center;
  margin: auto; 
}

.navbar-desktop-menu {
  display: flex; 
  justify-content: center; 
}

.navbar-desktop-menu li {
  margin-right: 20px; 
}

.navbar-menu {
  padding: 0;
  overflow: hidden; 
  max-height: 0; 
  transition: max-height 0.3s ease; 
}

.navbar-menu-open {
  max-height: 200px; 
}

.navbar-menu li {
  margin-right: 20px;
  display: inline-block; 
}
.navbar-menu li a {
  text-decoration: none;
  color: white; 
  display: block; 
}

.navbar-toggle-container {
  margin-left: 10px; 
}

.navbar-toggle {
  background: none;
  border: none;
  cursor: pointer;
  font-size: 1.5rem;
  color: white;
}

.bar {
  display: block;
  width: 25px;
  height: 3px;
  background-color: white;
  margin: 5px 0;
}

.open .bar:nth-child(1) {
  transform: translateY(8px) rotate(45deg);
}

.open .bar:nth-child(2) {
  opacity: 0;
}

.open .bar:nth-child(3) {
  transform: translateY(-8px) rotate(-45deg);
}

@media (min-width: 769px) {
  .mobile-menu {
    display: none; 
  }

  .navbar-menu-open {
    display: flex;
    flex-direction: column; 
    align-items: center; 
    justify-content: center; 
  }

  .navbar-menu-open li {
    margin-bottom: 10px; 
  }

}

@media (max-width: 768px) {
  .navbar-menu li,
  .navbar-desktop-menu li {
    margin-right: 0; 
    display: block; 
  }
}
.navbar-toggle {
  margin-right: 150px;
}
.margin-element {
  margin-bottom: 4px;
}

li{
  color: white;
}
.logo-icon {
  display: inline-block;
  width: 40px; 
  height: 40px; 
  background-image: url('../../public/logo.png'); 
  background-size: cover; 
  background-repeat: no-repeat;
  margin-left: 5px;
}
</style>
