import places from 'places.js';

const initAutocomplete = () => {
  // const addressInput = document.getElementById('location_address');
  const addressForm = document.querySelector(".form-home-banner");
  const addressFormNew = document.querySelector("#new_storage");
  if (addressForm) {
    places({ container: addressForm});
    // places({ container: addressInput });
  }
  if (addressFormNew) {
    places({ container: addressFormNew });
    // places({ container: addressInput });
  }
};

export { initAutocomplete };
