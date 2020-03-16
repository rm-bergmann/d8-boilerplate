module.exports = {
  components: './front-end/playroom/components',
  outputPath: './front-end/playroom/build',

  // Optional:
  title: 'D8 Boilerplate Library',
  widths: [320, 375, 768, 1024],
  port: 8093,
  openBrowser: false,
  exampleCode: `
    <Button>
      Hello World!
    </Button>
  `,
  baseUrl: '/playroom/',
};