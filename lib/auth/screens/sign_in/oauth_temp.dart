// import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart' as url_launcher;

// These URLs are endpoints that are provided by the authorization
// server. They're usually included in the server's documentation of its
// OAuth2 API.
final authorizationEndpoint = Uri.parse('https://auth.mangadex.org/realms/mangadex/protocol/openid-connect/auth');
final tokenEndpoint = Uri.parse('https://auth.mangadex.org/realms/mangadex/protocol/openid-connect/auth');

// The authorization server will issue each client a separate client
// identifier and secret, which allows the server to tell which client
// is accessing it. Some servers may also have an anonymous
// identifier/secret pair that any client may use.
//
// Note that clients whose source code or binary executable is readily
// available may not be able to make sure the client secret is kept a
// secret. This is fine; OAuth2 servers generally won't rely on knowing
// with certainty that a client is who it claims to be.
const identifier = 'mangadex-flutter';
const secret = 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0Q03sBcHI4uPsPpxwhJckgi6wH0uSr2Q4XA73my9r+zFmkQldrMi+Rsn4TXvbjEVXKSGBe5YOsBGq0ySbzUk+nOUfBwIWzjfVnfKhKa/k/ztnNs2TO/IG4WWaYrHdGt1I28FQKKiT4zynchDRjLu7TXpgjZjRWkHU5rlQzQOwkrQdjrEiCGGtro8T2w64OMkXl2h/GotC9UPdwSzdsLMKolkw/OVKhfFdxY8m4ln8MGOjJ6CHWm2l5hBGM8poi7G50XFyzdvvrC6FmFI6YC8kfTZxFoxu5yvPfNieQc7DLOwsAy8kFx5cRpz7mZxomNRea33/xV2ywAtaWM2sS8vEQIDAQAB';

// This is a URL on your application's server. The authorization server
// will redirect the resource owner here once they've authorized the
// client. The redirection will include the authorization code in the
// query parameters.
final redirectUrl = Uri.parse('https://my-site.com/oauth2-redirect');

/// A file in which the users credentials are stored persistently. If the server
/// issues a refresh token allowing the client to refresh outdated credentials,
/// these may be valid indefinitely, meaning the user never has to
/// re-authenticate.
// final credentialsFile = File('~/.myapp/credentials.json');

/// Either load an OAuth2 client from saved credentials or authenticate a new
/// one.
Future<void> authWithOAuth() async {
  // var exists = await credentialsFile.exists();

  // If the OAuth2 credentials have already been saved from a previous run, we
  // just want to reload them.
  // if (exists) {
  //   var credentials =
  //   oauth2.Credentials.fromJson(await credentialsFile.readAsString());
  //   return oauth2.Client(credentials, identifier: identifier, secret: secret);
  // }

  // If we don't have OAuth2 credentials yet, we need to get the resource owner
  // to authorize us. We're assuming here that we're a command-line application.
  var grant = oauth2.AuthorizationCodeGrant(
    identifier,
    authorizationEndpoint,
    tokenEndpoint,
    secret: secret,
  );

  // A URL on the authorization server (authorizationEndpoint with some additional
  // query parameters). Scopes and state can optionally be passed into this method.
  var authorizationUrl = grant.getAuthorizationUrl(
    redirectUrl,
    scopes: [
      'openid',
      'email',
      'groups',
      'profile',
      'roles',
    ],
  );

  debugPrint(authorizationUrl.toString());

  // Redirect the resource owner to the authorization URL. Once the resource
  // owner has authorized, they'll be redirected to `redirectUrl` with an
  // authorization code. The `redirect` should cause the browser to redirect to
  // another URL which should also have a listener.
  //
  // `redirect` and `listen` are not shown implemented here. See below for the
  // details.

  if (await url_launcher.canLaunchUrl(authorizationUrl)) {
    await url_launcher.launchUrl(authorizationUrl);
  }
  // var responseUrl = await listen(redirectUrl);

  // Once the user is redirected to `redirectUrl`, pass the query parameters to
  // the AuthorizationCodeGrant. It will validate them and extract the
  // authorization code to create a new Client.
  // return await grant.handleAuthorizationResponse(responseUrl.queryParameters);
}
