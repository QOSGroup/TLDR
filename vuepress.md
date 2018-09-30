
vuepress can create a very user-friendly doc. It compiles markdown document to html and you can have a fancy navgation side bar.

[How to write the layout of your document](https://vuepress.vuejs.org/zh/default-theme-config/#%E9%A6%96%E9%A1%B5)

[How to install and run](https://vuepress.vuejs.org/zh/guide/)

config.js example
```
module.exports = {
  title: 'Hello VuePress',
  description: '',
  themeConfig: {
    sidebar: [
 {
        title: 'Group 1',
        collapsable: false,
        children: [
          '/'
        ]
      },
      {
        title: 'Group 2',
	collapsable: false,
        children: [ 
      '/',
      '/pagea',
      ['/pageb', 'Explicit link text']

 ]
      }

]
  }
}
```
