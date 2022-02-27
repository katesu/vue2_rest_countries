<template>
  <table class="table table-striped table-responsive-lg">
    <thead>
      <tr>
        <th scope="col">國旗</th>
        <th scope="col">
          國家名稱
          <a>
            <i class="bi bi-sort-alpha-down" style="font-size:20px"></i>
          </a>
        </th>
        <th>2位國家代碼</th>
        <th>3位國家代碼</th>
        <th>母語名稱</th>
        <th>替代國家名稱</th>
        <th>國際電話區號</th>
      </tr>
    </thead>

    <tbody>
      <tr v-for="(country, index) in countries" :key="index">
        <td class="flag">
          {{ index }}
          <a href="#" @click.prevent="showModal(country.ccn3)">
            <img
              :src="country.flags.png"
              :alt="country.name.official"
              class="flag-img"
            />
          </a>
        </td>
        <td>{{ country.name.official }}</td>
        <td>{{ country.cca2 }}</td>
        <td>{{ country.cca3 }}</td>
        <td>
          <div
            v-for="(lang, index) in country.name.nativeName"
            :key="index"
            class="text-left mb-2"
          >
            <span class="alert-dark p-1">{{ index.toUpperCase() }}</span>
            <span>{{ `${lang.official}` }}</span>
          </div>
        </td>
        <td>
          <span
            v-for="(spelling, index) in country.altSpellings"
            :key="index"
            :class="[
              'd-block',
              Object.keys(country.altSpellings).length > 1 && 'border'
            ]"
            >{{ spelling }}</span
          >
        </td>
        <td class="idd">
          <span
            v-for="(suffix, index) in country.idd.suffixes"
            :key="index"
            class="d-block"
            >{{ `${country.idd.root}${suffix}` }}</span
          >
        </td>
      </tr>
    </tbody>
    <Modal ref="modalRef"></Modal>
  </table>
</template>

<script>
import Modal from "./Modal.vue";

export default {
  name: "DataTable",
  components: { Modal },
  props: {
    countries: {
      type: [Array],
      default: []
    }
  },
  data() {
    return {};
  },
  computed: {},
  methods: {
    async showModal(ccn3) {
      this.$refs.modalRef.country = await this.fetchCountry(ccn3);
      $("#countryDetail").modal("show");
    },
    async fetchCountry(ccn3) {
      const url = `https://restcountries.com/v3.1/alpha/${ccn3}`;
      let data = {};
      
      await fetch(url, {})
        .then(res => res.json())
        .then(res => {
          data = res[0];
        })
        .catch(err => {
          throw err;
        });

      return data;
    }
  }
};
</script>

<style lang="sass" scoped>
.flag-img
  max-width: 100%
  min-width: 100px
  height: auto
.idd
  min-width: 120px
</style>
