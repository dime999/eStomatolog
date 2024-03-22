<template>
  <div class="mobile-app">
    <img src="../assets/footer.png" alt="Footer slika" class="footer-image">
  </div>
</template>

<script>
export default {
  name: 'MobileApp',
}
</script>

<style scoped>
.mobile-app {
  /* Stilovi za MobileApp komponentu */
  position: relative;
  width: 100%; /* Postavljanje širine na 100% */
  height: 100%; /* Postavljanje visine na 100% */
  overflow: hidden; /* Skrivanje sadržaja koji prelazi granice */
}

.mobile-app::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  filter: blur(4px);
  z-index: -1;
}

.footer-image {
  width: 90%; /* Smanjujemo širinu slike */
  padding: 20px; /* Dodajemo malo paddinga oko slike */
  margin: auto; /* Centriramo sliku */
  box-shadow: 0 100px 200px rgba(0, 0, 0, 0.1); /* Dodajemo sjenu */
}
</style>
