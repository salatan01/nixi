{ config, pkgs, ... }:
{
  programs.librewolf = {
    enable = false;

    # Add this outside the settings block if you use a password manager extension
    # programs.librewolf.nativeMessagingHosts = [ pkgs.keepassxc ];

    settings = {
      # ── HTTPS & Network Security ──────────────────────────────────────────
      "dom.security.https_only_mode" = true;
      "dom.security.https_only_mode_pbm" = true;
      "network.http.referer.XOriginPolicy" = 2;
      "network.http.referer.XOriginTrimmingPolicy" = 2;
      "network.http.referer.defaultPolicy" = 2;
      "network.prefetch-next" = false;
      "network.dns.disablePrefetch" = true;
      "network.predictor.enabled" = false;

      # ── TLS Hardening ─────────────────────────────────────────────────────
      "security.tls.version.min" = 3; # TLS 1.2 minimum (3=1.2, 4=1.3)
      "security.ssl.require_safe_negotiation" = true;
      "security.ssl.treat_unsafe_negotiation_as_broken" = true;

      # ── Certificate Validation ────────────────────────────────────────────
      "security.OCSP.enabled" = 1; # Explicitly on
      "security.OCSP.require" = true; # Hard-fail on revoked certs
      # My addition: stapling avoids a live OCSP request (faster + no OCSP server tracking you)
      "security.ssl.enable_ocsp_stapling" = true;

      # ── Fingerprinting ────────────────────────────────────────────────────
      "privacy.resistFingerprinting" = true;
      "privacy.resistFingerprinting.block_mozAddonManager" = true;
      "webgl.disabled" = true;
      "media.peerconnection.enabled" = false;
      "dom.webaudio.enabled" = false;

      # ── Anti-Session Hijack ───────────────────────────────────────────────
      "network.IDN_show_punycode" = true;
      "browser.sessionstore.privacy_level" = 2;
      "privacy.partition.network_state" = true;
      "privacy.firstparty.isolate" = true; # SSO loops if this breaks — FPI is why
      "browser.sessionhistory.max_entries" = 50; # Prevents back-button hijack
      "browser.cache.disk.enable" = false; # RAM only — no session data on disk

      # ── Tracking & Telemetry ──────────────────────────────────────────────
      "datareporting.healthreport.uploadEnabled" = false;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.unified" = false;
      "toolkit.telemetry.server" = "";
      "browser.ping-centre.telemetry" = false;
      "beacon.enabled" = false;

      # ── Cookies & Storage ─────────────────────────────────────────────────
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cache" = true;
      "privacy.clearOnShutdown.formdata" = true;
      "network.cookie.thirdparty.sessionOnly" = true;
      "network.cookie.thirdparty.nonsecureSessionOnly" = true;

      # ── Firefox Account / Sync ────────────────────────────────────────────
      "identity.fxaccounts.enabled" = false;

      # ── Safe Browsing ─────────────────────────────────────────────────────
      "browser.safebrowsing.malware.enabled" = false;
      "browser.safebrowsing.phishing.enabled" = false;
      "browser.safebrowsing.downloads.remote.enabled" = false;

      # ── Search ────────────────────────────────────────────────────────────
      "browser.search.suggest.enabled" = false;
      "browser.urlbar.suggest.searches" = false;
      "browser.urlbar.speculativeConnect.enabled" = false;

      # ── UI / Behaviour ────────────────────────────────────────────────────
      "browser.newtabpage.enabled" = false;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.startup.page" = 0;
      "browser.shell.checkDefaultBrowser" = false;
      "browser.tabs.closeWindowWithLastTab" = false;
      "full-screen-api.warning.timeout" = 0;
    };
  };
}
