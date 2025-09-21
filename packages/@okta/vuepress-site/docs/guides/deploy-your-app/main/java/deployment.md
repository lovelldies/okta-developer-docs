## Deploy a Java app

If you're developing a server-side app, you likely only need to do three things after deploying your app:

1. Configure your app (or server settings) to force HTTPS.
1. Configure your app to read your Okta settings (issuer, client ID, and client secret) from environment variables or a secrets provider (HashiCorp Vault).
1. Modify your Okta app to have sign-in and sign-out redirect URIs that match your production app.

Java apps typically are built into a WAR or a JAR for production.

If you deploy your app as a WAR, it's possible you have a context path. If you do, add this path to your sign-in redirect URI and your sign-out redirect URI for your Okta app.

JAR-based Java apps usually don't have a context, and if you start them locally, they're available at `http://localhost:8080`.

## Heroku

The easiest way to deploy your Java app to production with Okta is to use Heroku.

To begin, install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) and run `heroku login`.

You can deploy your Java app to Heroku in five steps:

1. Run `heroku create`.
2. Add the Git remote that's created as a remote for your project.

   ```
   git remote add heroku <heroku-repo>
   ```

3. Run `heroku addons:create okta`.
4. Create a `Profile` that sets the `PORT` and your Okta configuration.

   ```
   web: java -Dserver.port=$PORT -Dokta.oauth2.client-id={OKTA_OAUTH2_CLIENT_ID_WEB} -Dokta.oauth2.client-secret={OKTA_OAUTH2_CLIENT_SECRET_WEB} -jar target/*.jar
   ```

5. Commit your changes and run `git push heroku master`.

If your branch isn't named `master`, run:

```
git push --set-upstream heroku <branch-name>
```

**Tip:** If you want to use a different version of Java, create a `system.properties` and add `java.runtime.version=11` (or another version) to it.

You can't sign in to your app until you add your Heroku app's URLs to your sign-in and sign-out redirect URIs in Okta.

For more information, see [Deploy a Secure Spring Boot App to Heroku](https://developer.okta.com/blog/2020/08/31/spring-boot-heroku).

## Force HTTPS

You can enforce the use of HTTPS when your app is running on Heroku by adding the following configuration to your security configuration.

```java
@Configuration
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

  @Override
  protected void configure(HttpSecurity http) throws Exception {
    http.requiresChannel()
      .requestMatchers(r -> r.getHeader("X-Forwarded-Proto") != null)
      .requiresSecure();
  }
}
```

## Docker

You can package your Java app with Docker, too. See [Angular + Docker with a Big Hug from Spring Boot](https://developer.okta.com/blog/2020/06/17/angular-docker-spring-boot) for a blog post that details how. Specifically, see the [Dockerize Angular + Spring Boot with Jib](https://developer.okta.com/blog/2020/06/17/angular-docker-spring-boot#dockerize-angular-spring-boot-with-jib) section.
