module.exports = {
  content: [
    "./app/components/**/*.html.erb",
    "./app/components/**/*.rb",
    "./app/views/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/assets/stylesheets/**/*.css",
    "./app/javascript/**/*.js",
  ],
  theme: {
    extend: {
      colors: {
        brand: {
          500: "#AACCFF",
          700: "#ccaaFF",
        },
      },
    },
  },
};
