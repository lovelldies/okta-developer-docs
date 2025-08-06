You need recent versions of [Node](https://nodejs.org/en/) and [npm](https://www.npmjs.com/).

1. Create a React app named `okta-react-quickstart` using the following command:

   ```shell
   npm create vite@5.4 okta-react-quickstart
   ```

2. You're asked to manually select the template:

    * Select **React** for the framework.
    * Select **JavaScript** for the variant.

3. Go into your app's root directory to view the created files and install dependencies:

   ```shell
   cd okta-react-quickstart
   npm install
   ```

> **Note**: This guide was tested with Vite 5.4, React 18.3, Okta React 6.9, and Okta Auth JavaScript SDK 7.8.

> **Note**: This quickstart uses `npm create vite`'s output, as it's easier to understand the Okta-specific additions if you work through them yourself.
