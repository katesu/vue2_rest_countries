<template>
  <nav v-show="data.length" aria-label="Page navigation">
    <ul class="pagination justify-content-center">
      <li :class="['page-item', !hasPrevPage && 'disabled']">
        <a
          @click="switchPage"
          :data-page="currentPage - 1"
          href="#"
          class="page-link"
          >Previous</a
        >
      </li>
      <li
        v-for="i in pageTotal"
        :key="i"
        :class="['page-item', i === currentPage && 'active']"
      >
        <a @click="switchPage" :data-page="i" class="page-link" href="#">{{
          i
        }}</a>
      </li>
      <li :class="['page-item', !hasNextPage && 'disabled']">
        <a
          @click="switchPage"
          :data-page="currentPage + 1"
          class="page-link"
          href="#"
          >Next</a
        >
      </li>
    </ul>
  </nav>
</template>

<script>
export default {
  name: "Pagination",
  props: {
    data: {
      type: [Array],
      default: []
    }
  },
  data() {
    return {
      dataCopy: [],
      perPage: 25,
      pageTotal: 0,
      currentPage: 0,
      hasPrevPage: false,
      hasNextPage: false
    };
  },
  methods: {
    pagination(data, targetPage) {
      const dataTotal = data.length;
      const pageTotal = Math.ceil(dataTotal / this.perPage);
      const currentPage = targetPage > pageTotal ? pageTotal : targetPage;
      const dataScope = {
        from: this.perPage * (currentPage - 1) + 1,
        end: this.perPage * currentPage
      };

      this.pageTotal = pageTotal;
      this.currentPage = currentPage;
      this.hasPrevPage = pageTotal > 1 && currentPage - 1 !== 0;
      this.hasNextPage = currentPage < pageTotal;
      this.$emit("updateDataScope", dataScope);
    },
    switchPage(e) {
      const page = Number(e.currentTarget.getAttribute("data-page"));
      this.pagination(this.dataCopy, page);
    }
  },
  watch: {
    data(data) {
      this.dataCopy = [...data];
      this.pagination(this.dataCopy, 1);
    }
  },
  mounted() {}
};
</script>

<style scoped></style>
