module.exports = {
  content: [
    './app/components/**/*.html.erb',
    './app/components/**/*.rb',
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
  ],
  safelist: [
    {
      pattern: /bg-(.*)-(50|100|200|300|400|500|600|700|800|900)/,
      variants: ['hover', 'focus', 'disabled'],
    },
  ],
  theme: {
    extend: {
      colors: {
        brand: {
          blue: {
            50: '#F2F3F7',
            100: '#D4DDE8',
            200: '#B9C9D8',
            300: '#9EB4C9',
            400: '#849EBB',
            500: '#6988AC',
            600: '#547296',
            700: '#445E7A',
            800: '#354961',
            900: '#283343',
            950: '#161F2A',
          },
        },
      },
    },
  },
};
