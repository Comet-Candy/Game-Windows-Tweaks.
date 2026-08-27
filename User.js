// Custom Services wrapper handlers to safely route configurations
var user_pref = function(pref, val){ 
    try { 
        if(typeof val == "string"){ 
            Services.prefs.setStringPref(pref, val); 
        } else if(typeof val == "number"){ 
            Services.prefs.setIntPref(pref, val); 
        } else if(typeof val == "boolean"){ 
            Services.prefs.setBoolPref(pref, val); 
        } 
    } catch(e){ 
        console.log("pref:" + pref + " val:" + val + " e:" + e); 
    } 
} 

var clearPref = function(pref){
    try {
        Services.prefs.clearUserPref(pref);
    } catch(e){
        console.log("clearPref error:" + pref + " e:" + e);
    }
}

// --- PASTE PREFERENCES BELOW THIS LINE ---

/****************************************************************************
 * SECTION: SECUREFOX                                                       *
 ****************************************************************************/
/** TRACKING PROTECTION ***/
user_pref("browser.contentblocking.category", "strict"); // CORRECTED: Kept at absolute strict enforcement
user_pref("browser.download.start_downloads_in_tmp_dir", true);
user_pref("browser.uitour.enabled", false);
user_pref("privacy.globalprivacycontrol.enabled", true);

/** OCSP & CERTS / HPKP ***/
user_pref("security.OCSP.enabled", 0);
user_pref("privacy.antitracking.isolateContentScriptResources", true);
user_pref("security.csp.reporting.enabled", false);

/** SSL / TLS ***/
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
user_pref("browser.xul.error_pages.expert_bad_cert", true);
user_pref("security.tls.enable_0rtt_data", false);

/** DISK AVOIDANCE ***/
user_pref("browser.cache.disk.enable", false);
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
user_pref("media.memory_cache_max_size", 65536);
user_pref("browser.sessionstore.interval", 150000); // Optimized to your preferred 150000ms value

/** SHUTDOWN & SANITIZING ***/
user_pref("privacy.history.custom", true);
user_pref("browser.privatebrowsing.resetPBM.enabled", true);

/** SPECULATIVE LOADING ***/
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.places.speculativeConnect.enabled", false);
user_pref("network.prefetch-next", false);

/** SEARCH / URL BAR ***/
user_pref("browser.urlbar.trimHttps", true);
user_pref("browser.urlbar.untrimOnUserInteraction.featureGate", true);
user_pref("browser.search.separatePrivateDefault.ui.enabled", true);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.quicksuggest.enabled", false);
user_pref("browser.urlbar.groupLabels.enabled", false);
user_pref("browser.formfill.enable", false);
user_pref("network.IDN_show_punycode", true);

/** HTTPS-ONLY MODE ***/
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_error_page_user_suggestions", true);

/** PASSWORDS ***/
user_pref("signon.formlessCapture.enabled", false);
user_pref("signon.privateBrowsingCapture.enabled", false);
user_pref("network.auth.subresource-http-auth-allow", 1);
user_pref("editor.truncate_user_pastes", false);

/** EXTENSIONS ***/
user_pref("extensions.enabledScopes", 5);

/** HEADERS / REFERERS ***/
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

/** CONTAINERS ***/
user_pref("privacy.userContext.ui.enabled", true);

/** VARIOUS ***/
user_pref("pdfjs.enableScripting", false);

/** SAFE BROWSING ***/
user_pref("browser.safebrowsing.downloads.remote.enabled", false);

/** MOZILLA ***/
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 0); // Kept at your override value 0
user_pref("geo.provider.network.url", "https://beacondb.net");
user_pref("browser.search.update", false);
user_pref("permissions.manager.defaultsUrl", "");
user_pref("extensions.getAddons.cache.enabled", false);

/** TELEMETRY ***/
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("datareporting.usage.uploadEnabled", false);

/** EXPERIMENTS ***/
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

/** CRASH REPORTS ***/
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false);

/****************************************************************************
 * SECTION: PESKYFOX                                                        *
 ****************************************************************************/
/** MOZILLA UI ***/
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.preferences.moreFromMozilla", false);
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.aboutwelcome.enabled", false);
user_pref("browser.profiles.enabled", true);

/** THEME ADJUSTMENTS ***/
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.compactmode.show", true);
user_pref("browser.privateWindowSeparation.enabled", false);

/** AI ***/
user_pref("browser.ai.control.default", "blocked");
user_pref("browser.ml.enable", false);
user_pref("browser.ml.chat.enabled", false);
user_pref("browser.ml.chat.menu", false);
user_pref("browser.tabs.groups.smart.enabled", false);
user_pref("browser.ml.linkPreview.enabled", false);

/** FULLSCREEN NOTICE ***/
user_pref("full-screen-api.transition-duration.enter", "0 0");
user_pref("full-screen-api.transition-duration.leave", "0 0");
user_pref("full-screen-api.warning.timeout", 0);

/** URL BAR ***/
user_pref("browser.urlbar.trending.featureGate", false);

/** NEW TAB PAGE ***/
user_pref("browser.newtabpage.activity-stream.default.sites", "");
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false);

/** DOWNLOADS ***/
user_pref("browser.download.manager.addToRecentDocs", false);

/** PDF ***/
user_pref("browser.download.open_pdf_attachments_inline", true);

/** TAB BEHAVIOR ***/
user_pref("browser.bookmarks.openInTabClosesMenu", false);
user_pref("browser.menu.showViewImageInfo", true);
user_pref("findbar.highlightAll", true);
user_pref("layout.word_select.eat_space_to_next_word", false);

/****************************************************************************
 * SECTION: SMOOTHFOX                                                       *
 ****************************************************************************/
// Smoothfox configurations can be loaded here if needed.

/****************************************************************************
 * START: MY OVERRIDES                                                      *
 ****************************************************************************/
user_pref("accessibility.browsewithcaret_shortcut.enabled", false);
user_pref("accessibility.force_disabled", 1);
user_pref("browser.cache.jsbc_compression_level", 3);
user_pref("browser.download.alwaysOpenPanel", false);
user_pref("browser.download.autohideButton", false);
user_pref("browser.download.manager.scanWhenDone", false);
user_pref("browser.engagement.downloads-button.has-used", true);
user_pref("browser.ml.chat.page", false);
user_pref("browser.ml.chat.page.footerBadge", false);
user_pref("browser.ml.chat.page.menuBadge", false);
user_pref("browser.ml.checkForMemory", false);
user_pref("browser.ml.linkPreview.shift", false);
user_pref("browser.ml.pageAssist.enabled", false);
user_pref("browser.ml.smartAssist.enabled", false);
user_pref("browser.newtabpage.activity-stream.filterAdult", true);
user_pref("browser.newtabpage.activity-stream.newtabLayouts.variant-a", false);
user_pref("browser.newtabpage.activity-stream.newtabLayouts.variant-b", false);
user_pref("browser.newtabpage.activity-stream.newtabShortcuts.refresh", false);
user_pref("browser.newtabpage.activity-stream.telemetry.structuredIngestion.endpoint", "");
user_pref("browser.ping-centre.telemetry", false);
user_pref("browser.preferences.defaultPerformanceSettings.enabled", false);
user_pref("browser.proton.contextmenus.enabled", 0);
user_pref("browser.proton.doorhangers.enabled", 0);
user_pref("browser.proton.enabled", 0);
user_pref("browser.proton.modals.enabled", 0);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.malware.enabled", false);
/****************************************************************************
 * SECTION 3: CUSTOM OVERRIDES & ADVANCED DATA PROFILES                     *
 ****************************************************************************/
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.search.visualSearch.featureGate", false);
user_pref("browser.selfsupport.url", "");
user_pref("browser.startup.preXulSkeletonUI", false);
user_pref("browser.tabs.groups.enabled", false);
user_pref("browser.tabs.hoverPreview.showThumbnails", false);
user_pref("browser.tabs.loadBookmarksInTabs", true);
user_pref("browser.tabs.tabmanager.enabled", false);
user_pref("browser.taskbarTabs.enabled", false);
user_pref("browser.translations.automaticallyPopup", false);
user_pref("browser.translations.enable", false);
user_pref("browser.urlbar.suggest.recentsearches", false);
user_pref("browser.urlbar.suggest.trending", false);
user_pref("browser.vpn_promo.enabled", 0);
user_pref("datareporting.policy.firstRunURL", "");
user_pref("datareporting.sessions.current.clean", false);
user_pref("devtools.onboarding.telemetry.logged", false);
user_pref("dom.allow_scripts_to_close_windows", true);
user_pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled", false);
user_pref("dom.ipc.processPriorityManager.backgroundUsesEcoQoS", false);
user_pref("dom.serviceWorkers.enabled", false);
user_pref("dom.webnotifications.serviceworker.enabled", false);
user_pref("experiments.activeExperiment", false);
user_pref("experiments.enabled", false);
user_pref("experiments.supported", false);
user_pref("extensions.ml.enabled", false);
user_pref("extensions.pocket.onSaveRecs", false);
user_pref("gfx.color_management.mode", 1);
user_pref("gfx.webrender.compositor", false);
user_pref("gtk-enable-animations", false);
user_pref("layers.acceleration.disabled", true);
user_pref("layout.css.prefers-color-scheme.content-override", 1);
user_pref("media.autoplay.blocking_policy", 2);
user_pref("media.gpu-process-decoder", false);
user_pref("media.hardwaremediakeys.enabled", false);
user_pref("media.hardware-video-decoding.enabled", false);
user_pref("media.peerconnection.enabled", false);
user_pref("media.videocontrols.picture-in-picture.video-toggle.has-used", true);
user_pref("narrate.filter-voices", false);
user_pref("network.allow-experiments", false);
user_pref("network.dns.disableIPv6", false);
user_pref("network.http.http3.enable", false);
user_pref("pdfjs.enableAltText", false);
user_pref("places.semanticHistory.featureGate", false);
user_pref("services.sync.prefs.sync.browser.safebrowsing.downloads.enabled", false);
user_pref("sidebar.animation.enabled", false);
user_pref("sidebar.revamp", false);
user_pref("toolkit.telemetry.hybridContent.enabled", false);
user_pref("toolkit.telemetry.prompted", 2);
user_pref("toolkit.telemetry.rejected", false);
user_pref("toolkit.telemetry.unifiedIsOptIn", false);
user_pref("ui.prefersReducedMotion", 1);
user_pref("webgl.disabled", true);
user_pref("browser.download.skipConfirmLaunchExecutable", true);
user_pref("browser.nova.enabled", false);
user_pref("sidebar.animation.expand-on-hover.delay-duration-ms", 10);
user_pref("sidebar.animation.expand-on-hover.duration-ms", 100);

// --- RAN-SAMA PROFILE CLEANUP COMMANDS ---
clearPref("app.installation.timestamp");
clearPref("app.normandy.user_id");
clearPref("beacon.enabled");
clearPref("browser.contextual-services.contextId");
clearPref("browser.newtabpage.activity-stream.impressionId");
clearPref("browser.search.totalSearches");
clearPref("datareporting.dau.cachedUsageProfileGroupID");
clearPref("datareporting.dau.cachedUsageProfileID");
clearPref("dom.push.connection.enabled");
clearPref("dom.push.enabled");
clearPref("dom.push.serverURL");
clearPref("dom.push.userAgentID");
clearPref("nimbus.profileId");
clearPref("toolkit.telemetry.cachedClientID");
clearPref("toolkit.telemetry.cachedProfileGroupID");

// --- RECENTLY ADDED PREFERENCES ---
user_pref("accessibility.typeaheadfind.flashBar", 0);
user_pref("alerts.useSystemBackend", false);
user_pref("alerts.useSystemBackend.windows.notificationserver.enabled", false);
user_pref("browser.aiwindow.apiKey", "");
user_pref("browser.aiwindow.enabled", false);
user_pref("browser.aiwindow.endpoint", "");
user_pref("browser.aiwindow.firstrun.modelChoice", "");
user_pref("browser.aiwindow.insights", false);
user_pref("browser.aiwindow.model", "");
user_pref("browser.contentanalysis.default_allow", false);
user_pref("browser.contentanalysis.default_result", 0);
user_pref("browser.contentanalysis.enabled", false);
user_pref("browser.contentanalysis.interception_point.clipboard.enabled", false);
user_pref("browser.contentanalysis.interception_point.download.enabled", false);
user_pref("browser.contentanalysis.interception_point.drag_and_drop.enabled", false);
user_pref("browser.contentanalysis.interception_point.file_upload.enabled", false);
user_pref("browser.contentanalysis.interception_point.print.enabled", false);
user_pref("browser.contentanalysis.max_connections", 0);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.disableResetPrompt", true);
user_pref("browser.firefox-view.feature-tour", "{\"screen\":\"\",\"complete\":true}"); // Fixed escaped quotes for JS parsing
user_pref("browser.firefox-view.search.enabled", false);
user_pref("browser.firefox-view.virtual-list.enabled", false);
user_pref("browser.history.collectWireframes", false);
user_pref("browser.ipProtection.enabled", false);
user_pref("browser.browsingData.enabled", true);

