<template>
  <div>
    <table class="table table-striped table-responsive-lg">
      <thead>
        <tr class="d-flex">
          <th class="col-2">國旗</th>
          <th class="col-2">
            國家名稱
            <a @click="sortData" href="#" class="p-1">
              <i :class="sortClass"></i>
            </a>
          </th>
          <th class="col-1">2位國家代碼</th>
          <th class="col-1">3位國家代碼</th>
          <th class="col-2">母語名稱</th>
          <th class="col-2">替代國家名稱</th>
          <th class="col-2">國際電話區號</th>
        </tr>
      </thead>

      <tbody>
        <tr v-for="(country, index) in countries" :key="index" class="d-flex">
          <td class="col-2 idd">
            {{ index }}
            <a href="#" @click.prevent="showModal(country.ccn3)">
              <img
                :src="country.flags.png"
                :alt="country.name.official"
                class="flag-img"
              />
            </a>
          </td>
          <td class="col-2">{{ country.name.official }}</td>
          <td class="col-1">{{ country.cca2 }}</td>
          <td class="col-1">{{ country.cca3 }}</td>
          <td class="col-2">
            <div
              v-for="(lang, index) in country.name.nativeName"
              :key="index"
              class="text-left mb-2"
            >
              <span class="alert-dark p-1">{{ index.toUpperCase() }}</span>
              <span>{{ `${lang.official}` }}</span>
            </div>
          </td>
          <td class="col-2">
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
          <td class="col-2">
            <span
              v-for="(suffix, index) in country.idd.suffixes"
              :key="index"
              class="d-block"
              >{{ `${country.idd.root}${suffix}` }}</span
            >
          </td>
        </tr>
      </tbody>
    </table>
    <Modal ref="modalRef"></Modal>
    <p v-if="isLoading">資料載入中，請稍後</p>
    <p v-if="alert">{{ alert }}</p>
  </div>
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
    },
    alert: {
      type: [String],
      default: ""
    }
  },
  data() {
    return {
      sortBy: null,
      isLoading: true
    };
  },
  computed: {
    sortClass() {
      const isSort =
        this.sortBy === null ? this.sortBy : this.sortBy === "ascending";
      const style = ["bi", "icon"];

      if (isSort === null) {
        return [...style, "text-black-50", "bi-sort-alpha-down"];
      } else {
        return [
          ...style,
          "text-body",
          `bi-sort-alpha-${isSort ? "down" : "up"}`
        ];
      }
    }
  },
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
    },
    sortData() {
      if (this.sortBy === null) {
        this.sortBy = "ascending";
      } else {
        this.sortBy = this.sortBy === "ascending" ? "descending" : "ascending";
      }
      this.$emit("sortData", this.sortBy);
    }
  },
  watch: {
    countries(newVal, oldVal) {
      if (newVal.length > 0 && oldVal.length === 0) {
        this.isLoading = false;
      }
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
  min-width: 100px
.icon
  font-size: 20px
</style>
