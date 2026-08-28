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

// FIX: Added missing clearPref function to prevent script execution errors
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

// Core Tracking Protection & Global Privacy Controls
user_pref("browser.contentblocking.category", "strict");
user_pref("browser.download.start_downloads_in_tmp_dir", true);
user_pref("browser.uitour.enabled", false);
user_pref("privacy.globalprivacycontrol.enabled", true);
user_pref("privacy.antitracking.isolateContentScriptResources", true);

// OCSP, Security Certificates & CSP Error Reporting
user_pref("security.OCSP.enabled", 0);
user_pref("security.csp.reporting.enabled", false);

// Cryptographic TLS Handshakes & Advanced Cert Presentation
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
user_pref("browser.xul.error_pages.expert_bad_cert", true);
user_pref("security.tls.enable_0rtt_data", false);

// Disk Avoidance, In-Memory Streams & Session Frequencies
user_pref("browser.cache.disk.enable", false);
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
user_pref("media.memory_cache_max_size", 65536);
user_pref("browser.sessionstore.interval", 60000);

// History Controls & Private Browsing Isolation
user_pref("privacy.history.custom", true);
user_pref("browser.privatebrowsing.resetPBM.enabled", true);

// Speculative Connections, Prefetching & Resource Loading Disables
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.places.speculativeConnect.enabled", false);
user_pref("network.prefetch-next", false);

// Search Architecture, Autofill & URL Query Disables
user_pref("browser.urlbar.trimHttps", true);
user_pref("browser.urlbar.untrimOnUserInteraction.featureGate", true);
user_pref("browser.search.separatePrivateDefault.ui.enabled", true);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.quicksuggest.enabled", false);
user_pref("browser.urlbar.groupLabels.enabled", false);
user_pref("browser.formfill.enable", false);
user_pref("network.IDN_show_punycode", true);

/****************************************************************************
 * SECTION: ENCRYPTION, EXTENSION SCOPES & TELEMETRY FILTERS                 *
 ****************************************************************************/

// HTTPS-Only Strict Execution Mode
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_error_page_user_suggestions", true);

// Password Form Captures & Clipboard Sandbox Modification
user_pref("signon.formlessCapture.enabled", false);
user_pref("signon.privateBrowsingCapture.enabled", false);
user_pref("network.auth.subresource-http-auth-allow", 1);
user_pref("editor.truncate_user_pastes", false);

// Extension Scope Locking & Cross-Origin Referrer Headers
user_pref("extensions.enabledScopes", 5);
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

// Native Profile Containers UI Interface
user_pref("privacy.userContext.ui.enabled", true);

// Built-in PDF Script Engine Isolation
user_pref("pdfjs.enableScripting", false);

// Safe Browsing Automated Target Resets
user_pref("browser.safebrowsing.downloads.remote.enabled", false);

// Local Geolocation Services, Search Update Engine & Core Mozilla Blocks
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 2);
user_pref("geo.provider.network.url", "https://beacondb.net/v1/geolocate");
user_pref("browser.search.update", false);
user_pref("permissions.manager.defaultsUrl", "");
user_pref("extensions.getAddons.cache.enabled", false);

// Comprehensive Telemetry, Background Pings & Usage Reporting Disables
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

// Shield Studies & Normandy Background Experiments Disables
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

// Breakpad Crash Reporter Endpoint Nullification
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false);

/****************************************************************************
 * SECTION: PESKYFOX UI MODIFICATIONS                                       *
 ****************************************************************************/

// Mozilla Feature Recommendations & Extension Promotion Disables
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.preferences.moreFromMozilla", false);

// Interface Startup Transitions, Welcome Prompts & Profile Selectors
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("browser.aboutwelcome.enabled", false);
user_pref("browser.profiles.enabled", true);

// Legacy userChrome/userContent CSS Configuration & Theme Adjustments
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.compactmode.show", true);
user_pref("browser.privateWindowSeparation.enabled", false);

// Native AI Tooling, Chat Interfaces & Smart Tab Group Disables
user_pref("browser.ai.control.default", "blocked");
user_pref("browser.ml.enable", false);
user_pref("browser.ml.chat.enabled", false);
user_pref("browser.ml.chat.menu", false);
user_pref("browser.tabs.groups.smart.enabled", false);
user_pref("browser.ml.linkPreview.enabled", false);

// Fullscreen API Indicator Banner & Delay Disables
user_pref("full-screen-api.transition-duration.enter", "0 0");
user_pref("full-screen-api.transition-duration.leave", "0 0");
user_pref("full-screen-api.warning.timeout", 0);

// Address Bar Trending Search Metrics Disables
user_pref("browser.urlbar.trending.featureGate", false);

// Clean New Tab Page Layouts & Pocket Advertisement Removal
user_pref("browser.newtabpage.activity-stream.default.sites", "");
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false);

// Recent Document Tracker Bypass & Inline PDF Attachment Handling
user_pref("browser.download.manager.addToRecentDocs", false);
user_pref("browser.download.open_pdf_attachments_inline", true);

// Context Menu Retention, Findbar Highlighting & Word Select Mechanics
user_pref("browser.bookmarks.openInTabClosesMenu", false);
user_pref("browser.menu.showViewImageInfo", true);
user_pref("findbar.highlightAll", true);
user_pref("layout.word_select.eat_space_to_next_word", false);

/****************************************************************************
 * SECTION: SMOOTHFOX                                                       *
 ****************************************************************************/
// visit https://github.com/yokoffing/Betterfox/blob/main/Smoothfox.js

// Natural Smooth Scrolling Equation (Fluid 90Hz-144Hz+ Display Optimisation)
user_pref("apz.overscroll.enabled", true);
user_pref("general.smoothScroll", true);
user_pref("general.smoothScroll.msdPhysics.enabled", true);
user_pref("mousewheel.default.delta_multiplier_y", 300);
/****************************************************************************
 * SECTION: MY OVERRIDES - PERFORMANCE, CACHING & MEDIA                     *
 ****************************************************************************/

// Script Cache Compression Level Tweak
user_pref("browser.cache.jsbc_compression_level", 3);

// Download Interactive UI Triggers
user_pref("browser.download.alwaysOpenPanel", false);
user_pref("browser.download.autohideButton", false);
user_pref("browser.download.manager.scanWhenDone", false);
user_pref("browser.engagement.downloads-button.has-used", true);

// Advanced Machine Learning Feature Additions
user_pref("browser.ml.chat.page", false);
user_pref("browser.ml.chat.page.footerBadge", false);
user_pref("browser.ml.chat.page.menuBadge", false);
user_pref("browser.ml.checkForMemory", false);
user_pref("browser.ml.linkPreview.shift", false);
user_pref("browser.ml.pageAssist.enabled", false);
user_pref("browser.ml.smartAssist.enabled", false);

// Experimental Activity Stream Variant Layouts
user_pref("browser.newtabpage.activity-stream.filterAdult", true);
user_pref("browser.newtabpage.activity-stream.newtabLayouts.variant-a", false);
user_pref("browser.newtabpage.activity-stream.newtabLayouts.variant-b", false);
user_pref("browser.newtabpage.activity-stream.newtabShortcuts.refresh", false);

// Native Tab Layout Mechanics & Navigation Behavior
user_pref("browser.tabs.groups.enabled", false);
user_pref("browser.tabs.hoverPreview.showThumbnails", false);
user_pref("browser.tabs.loadBookmarksInTabs", true);
user_pref("browser.tabs.tabmanager.enabled", false);
user_pref("browser.taskbarTabs.enabled", false);

// Local Search Gateway & History Suggestion Toggles
user_pref("browser.search.visualSearch.featureGate", false);
user_pref("browser.urlbar.suggest.recentsearches", false);

// Internal Localization & Translation Interface Blocks
user_pref("browser.translations.automaticallyPopup", false);
user_pref("browser.translations.enable", false);

// Advanced Core Performance Profiles & Low-QoS Eco Scheduling
user_pref("browser.preferences.defaultPerformanceSettings.enabled", false);
user_pref("browser.startup.preXulSkeletonUI", false);
user_pref("dom.ipc.processPriorityManager.backgroundUsesEcoQoS", false);

// Graphics Colorspace, Hardware Compositors & Pipeline Disables
user_pref("gfx.color_management.mode", 1);
user_pref("gfx.webrender.compositor", false);
user_pref("layers.acceleration.disabled", true);
user_pref("layout.css.prefers-color-scheme.content-override", 1);

// Media Decoders, WebRTC PeerConnections & Autoplay Blocking
user_pref("media.autoplay.blocking_policy", 2);
user_pref("media.gpu-process-decoder", false);
user_pref("media.hardwaremediakeys.enabled", false);
user_pref("media.hardware-video-decoding.enabled", false);
user_pref("media.peerconnection.enabled", false);
user_pref("media.videocontrols.picture-in-picture.video-toggle.has-used", true);
user_pref("narrate.filter-voices", false);

// Legacy Networking Protocols & Alternative IP Formats
user_pref("network.dns.disableIPv6", false);
user_pref("network.http.http3.enable", false);

// Legacy Flash Integration Crash Handling
user_pref("dom.ipc.plugins.flash.subprocess.crashreporter.enabled", false);

/****************************************************************************
 * SECTION: MY OVERRIDES - SYSTEM INTERFACE & ADVANCED PRIVACY              *
 ****************************************************************************/

// PDF Viewer Accessibility Meta Text Disables
user_pref("pdfjs.enableAltText", false);

// Address Bar Suggestion History Graph Gates
user_pref("places.semanticHistory.featureGate", false);

// Cloud Sync Synchronization Target Restrictions
user_pref("services.sync.prefs.sync.browser.safebrowsing.downloads.enabled", false);

// Unified Sidebar Animation Engine, Timers & Hover Delays
user_pref("sidebar.animation.enabled", false);
user_pref("sidebar.animation.expand-on-hover.delay-duration-ms", 10);
user_pref("sidebar.animation.expand-on-hover.duration-ms", 100);
user_pref("sidebar.revamp", false);

// System UI Animation Reductions & Reduced Motion Triggers
user_pref("ui.prefersReducedMotion", 1);

// Advanced Graphics WebGL Vector Pipeline Disables
user_pref("webgl.disabled", true);

// Automated Download Interactivity & App Launches
user_pref("browser.download.skipConfirmLaunchExecutable", true);

// Experimental Nova Layout Feature Flags
user_pref("browser.nova.enabled", false);

// Hybrid Telemetry Collection & Metadata Prompt Disables
user_pref("toolkit.telemetry.hybridContent.enabled", false);
user_pref("toolkit.telemetry.prompted", 2);
user_pref("toolkit.telemetry.rejected", false);
user_pref("toolkit.telemetry.unifiedIsOptIn", false);

/****************************************************************************
 * SECTION: TELEMETRY RESETS & AI SANDBOX CONTROLS                          *
 ****************************************************************************/
// ran-sama

// Telemetry & Normandy Tracking Parameter Clears
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

// Typeahead UI & Native OS Backend Notification Management
user_pref("accessibility.typeaheadfind.flashBar", 0);
user_pref("alerts.useSystemBackend", false);
user_pref("alerts.useSystemBackend.windows.notificationserver.enabled", false);

// Experimental Custom AI Window Injection Barriers
user_pref("browser.aiwindow.apiKey", "");
user_pref("browser.aiwindow.enabled", false);
user_pref("browser.aiwindow.endpoint", "");
user_pref("browser.aiwindow.firstrun.modelChoice", "");
user_pref("browser.aiwindow.insights", false);
user_pref("browser.aiwindow.model", "");

// Content Analysis Protection Framework & Clipboard Interception
user_pref("browser.contentanalysis.default_allow", false);
user_pref("browser.contentanalysis.default_result", 0);
user_pref("browser.contentanalysis.enabled", false);
user_pref("browser.contentanalysis.interception_point.clipboard.enabled", false);
user_pref("browser.contentanalysis.interception_point.download.enabled", false);
user_pref("browser.contentanalysis.interception_point.drag_and_drop.enabled", false);
user_pref("browser.contentanalysis.interception_point.file_upload.enabled", false);
user_pref("browser.contentanalysis.interception_point.print.enabled", false);
user_pref("browser.contentanalysis.max_connections", 0);

// Crash Reports Verification Prompts
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.disableResetPrompt", true);

// Firefox View Interfaces & History Analytic Harvesting
user_pref("browser.firefox-view.feature-tour", "{\"screen\":\"\",\"complete\":true}");
user_pref("browser.firefox-view.search.enabled", false);
user_pref("browser.firefox-view.virtual-list.enabled", false);
user_pref("browser.history.collectWireframes", false);

// Native IP Protection Proxy Tunnel Configuration
user_pref("browser.ipProtection.enabled", false);
user_pref("browser.ipProtection.guardian.endpoint", "");
user_pref("browser.ipProtection.optedOut", true);
user_pref("browser.laterrun.enabled", false);
user_pref("browser.messaging-system.whatsNewPanel.enabled", false);

// Machine Learning Built-in Chat Framework Profiles
user_pref("browser.ml.chat.prompt.prefix", "");
user_pref("browser.ml.chat.prompts.0", "");
user_pref("browser.ml.chat.prompts.1", "");
user_pref("browser.ml.chat.prompts.2", "");
user_pref("browser.ml.chat.prompts.3", "");
user_pref("browser.ml.chat.prompts.4", "");
user_pref("browser.ml.chat.provider", "");
user_pref("browser.ml.chat.shortcuts.custom", false);
user_pref("browser.ml.chat.shortcuts", false);
user_pref("browser.ml.chat.sidebar", false);
user_pref("browser.ml.linkPreview.optin", false);
user_pref("browser.ml.modelHubRootUrl", "");
user_pref("browser.ml.smartAssist.endpoint", "");

// Activity Stream Router Snippets & Discovery Feeds
user_pref("browser.newtabpage.activity-stream.asrouter.providers.snippets", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.config", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.contextualContent.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.contextualContent.fakespot.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.endpoints", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.endpointSpocsClear", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.imageProxy.enabled", false);

// Merino Provider & OHTTP Routing Engine Restrictions
user_pref("browser.newtabpage.activity-stream.discoverystream.merino-provider.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.merino-provider.endpoint", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.merino-provider.ohttp.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.ohttp.configURL", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.ohttp.relayURL", "");

// Discovery Stream Custom Card Placements & Algorithmic Sections
user_pref("browser.newtabpage.activity-stream.discoverystream.personalization.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.personalization.modelKeys", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.placements.spocs", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.placements.tiles", "");
user_pref("browser.newtabpage.activity-stream.discoverystream.promoCard.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.promoCard.visible", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.sections.cards.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.sections.cards.thumbsUpDown.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.sections.contextualAds.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.sections.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.sections.interestPicker.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.sections.personalization.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.sections.personalization.inferred.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.sections.personalization.inferred.user.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.sections.topicSelection.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.shortcuts.personalization.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.spocs.personalized", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.spocs.startupCache.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.spocTopsitesPlacement.enabled", false);
user_pref("browser.newtabpage.activity-stream.discoverystream.topicLabels.enabled", false);

// Interface Highlights Feed Filters
user_pref("browser.newtabpage.activity-stream.externalComponents.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.adsfeed", false);

/****************************************************************************
 * SECTION: ACTIVITY STREAM INTERFACE & DATA DISCOVERY CLEANUP              *
 ****************************************************************************/

// Activity Stream Component Feeds & Highlight Configurations
user_pref("browser.newtabpage.activity-stream.feeds.externalcomponentsfeed", false);
user_pref("browser.newtabpage.activity-stream.feeds.inferredpersonalizationfeed", false);
user_pref("browser.newtabpage.activity-stream.feeds.newtabmessaging", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories.options", "");
user_pref("browser.newtabpage.activity-stream.feeds.smartshortcutsfeed", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", "");
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.feeds.trendingsearchfeed", false);
user_pref("browser.newtabpage.activity-stream.feeds.weatherfeed", false);

// Layout Sizing, Promotional Ads & System Easter Eggs
user_pref("browser.newtabpage.activity-stream.images.smart", false);
user_pref("browser.newtabpage.activity-stream.newtabAdSize.billboard", false);
user_pref("browser.newtabpage.activity-stream.newtabAdSize.leaderboard", false);
user_pref("browser.newtabpage.activity-stream.newtabLogo.aprilfools", false);
user_pref("browser.newtabpage.activity-stream.newtabWallpapers.customColor.enabled", false);

// Specific Highlight Feed Sourced Tracking Categories
user_pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
user_pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);
user_pref("browser.newtabpage.activity-stream.sov.enabled", false);

// Algorithmic Trending Search Modules
user_pref("browser.newtabpage.activity-stream.system.trendingSearch.enabled", false);
user_pref("browser.newtabpage.activity-stream.trendingSearch.enabled", false);

// Local Activity Stream Telemetry Pings
user_pref("browser.newtabpage.activity-stream.telemetry.privatePing.enabled", false);
user_pref("browser.newtabpage.activity-stream.telemetry.privatePing.inferredInterests.enabled", false);
user_pref("browser.newtabpage.activity-stream.telemetry.privatePing.redactNewtabPing.enabled", false);
user_pref("browser.newtabpage.activity-stream.telemetry.ut.events", false);

// Unified Advertisements Network Subsystem Blocks
user_pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.enabled", false);
user_pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.spocs.enabled", false);
user_pref("browser.newtabpage.activity-stream.unifiedAds.adsFeed.tiles.enabled", false);
user_pref("browser.newtabpage.activity-stream.unifiedAds.endpoint", "");
user_pref("browser.newtabpage.activity-stream.unifiedAds.ohttp.enabled", false);
user_pref("browser.newtabpage.activity-stream.unifiedAds.spocs.enabled", false);
user_pref("browser.newtabpage.activity-stream.unifiedAds.tiles.enabled", false);

// Weather Forecast Panel Widgets & Static Maps
user_pref("browser.newtabpage.activity-stream.weather.locationSearchEnabled", false);
user_pref("browser.newtabpage.activity-stream.weather.staticData.enabled", false);
user_pref("browser.newtabpage.activity-stream.widgets.enabled", false);
user_pref("browser.newtabpage.activity-stream.widgets.system.weatherForecast.enabled", false);
user_pref("browser.newtabpage.activity-stream.widgets.weatherForecast.enabled", false);

// Add-on Promotion Anchors & Page Thumbnail Pre-Rendering
user_pref("browser.newtabpage.trainhopAddon.xpiBaseURL", "");
user_pref("browser.pagethumbnails.capturing_disabled", true);
user_pref("browser.promo.focus.enabled", false);
user_pref("browser.promo.pin.enabled", false);

/****************************************************************************
 * SECTION: SAFE BROWSING NETWORKS & METRICS HARVESTING                     *
 ****************************************************************************/

// Remote Safe Browsing Verification URL Blockers
user_pref("browser.safebrowsing.downloads.remote.block_dangerous", false);
user_pref("browser.safebrowsing.downloads.remote.block_dangerous_host", false);
user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");

// Google Safe Browsing API v4 & v5 Data Collection Drops
user_pref("browser.safebrowsing.provider.google4.advisoryURL", "");
user_pref("browser.safebrowsing.provider.google4.dataSharing.enabled", false);
user_pref("browser.safebrowsing.provider.google4.dataSharingURL", "");
user_pref("browser.safebrowsing.provider.google4.gethashURL", "");
user_pref("browser.safebrowsing.provider.google4.lists", "");
user_pref("browser.safebrowsing.provider.google4.reportMalwareMistakeURL", "");
user_pref("browser.safebrowsing.provider.google4.reportPhishMistakeURL", "");
user_pref("browser.safebrowsing.provider.google4.reportURL", "");
user_pref("browser.safebrowsing.provider.google4.updateURL", "");
user_pref("browser.safebrowsing.provider.google5.advisoryURL", "");
user_pref("browser.safebrowsing.provider.google5.enabled", false);
user_pref("browser.safebrowsing.provider.google5.gethashURL", "");
user_pref("browser.safebrowsing.provider.google5.lists", "");
user_pref("browser.safebrowsing.provider.google5.updateURL", "");

// Legacy Google Safe Browsing Tracking Elements
user_pref("browser.safebrowsing.provider.google.advisoryURL", "");
user_pref("browser.safebrowsing.provider.google.gethashURL", "");
user_pref("browser.safebrowsing.provider.google.lists", "");
user_pref("browser.safebrowsing.provider.google.reportMalwareMistakeURL", "");
user_pref("browser.safebrowsing.provider.google.reportPhishMistakeURL", "");
user_pref("browser.safebrowsing.provider.google.reportURL", "");
user_pref("browser.safebrowsing.provider.google.updateURL", "");

// Mozilla Safe Browsing Callbacks
user_pref("browser.safebrowsing.provider.mozilla.gethashURL", "");
user_pref("browser.safebrowsing.provider.mozilla.lists", "");
user_pref("browser.safebrowsing.provider.mozilla.updateURL", "");
user_pref("browser.safebrowsing.reportPhishURL", "");

// Search Engine Results Page (SERP) Metric Counters
user_pref("browser.search.serpEventTelemetryCategorization.enabled", false);
user_pref("browser.search.serpEventTelemetry.enabled", false);
user_pref("browser.search.serpMetricsRecordedCounter", 0);

// Address Bar Suggest Private Query OHTTP Targets
user_pref("browser.search.suggest.enabled.private", false);
user_pref("browser.search.suggest.ohttp.enabled", false);
user_pref("browser.search.suggest.ohttp.featureGate", false);

// Hyperlink Auditing Pings
user_pref("browser.send_pings", false);

/****************************************************************************
 * SECTION: INTELLIGENT SHOPPING TELEMETRY SYSTEMS                          *
 ****************************************************************************/

// Shopping Review & Behavioral Tracking Disables
user_pref("browser.shopping.experience2023.active", false);
user_pref("browser.shopping.experience2023.ads.enabled", false);
user_pref("browser.shopping.experience2023.ads.userEnabled", false);
user_pref("browser.shopping.experience2023.autoClose.userEnabled", false);
user_pref("browser.shopping.experience2023.autoOpen.enabled", false);
user_pref("browser.shopping.experience2023.autoOpen.userEnabled", false);
user_pref("browser.shopping.experience2023.enabled", false);
user_pref("browser.shopping.experience2023.integratedSidebar", false);
user_pref("browser.shopping.experience2023.optedIn", 0);
user_pref("browser.shopping.experience2023.shoppingSidebar", false);
user_pref("browser.shopping.experience2023.survey.enabled", false);

/****************************************************************************
 * SECTION: CORE ENGINE BEHAVIORS                                           *
 ****************************************************************************/

// Busy State Spin Cursors & Windows Login Launch Actions
user_pref("browser.spin_cursor_while_busy", false);
user_pref("browser.startup.windowsLaunchOnLogin.disableLaunchOnLoginPrompt", true);
user_pref("browser.startup.windowsLaunchOnLogin.enabled", false);

// Firefox View Workspace Interface
user_pref("browser.tabs.firefox-view", false);

/****************************************************************************
 * SECTION: WORKSPACE REVIEWS & HOVER BEHAVIORS                             *
 ****************************************************************************/

// Firefox View Context Layout Elements
user_pref("browser.tabs.firefox-view-newIcon", false);
user_pref("browser.tabs.firefox-view-next", false);

// Smart Tab Categorization & Algorithmic Grouping
user_pref("browser.tabs.groups.smart.optin", false);
user_pref("browser.tabs.groups.smart.searchTopicEnabled", false);
user_pref("browser.tabs.groups.smart.userEnabled", false);

// Tab Deck Hover Previews & Memory Discards
user_pref("browser.tabs.hoverPreview.enabled", false);
user_pref("browser.tabs.unloadOnLowMemory", false);

/****************************************************************************
 * SECTION: ADDRESS BAR QUICKSUGGEST MERINO PIPELINES                      *
 ****************************************************************************/

// Terms Migration Validation & Contile Top Sites Overrides
user_pref("browser.termsofuse.prefMigrationCheck", true);
user_pref("browser.topsites.contile.enabled", false);
user_pref("browser.uitour.url", "");

// Feature Gates, Addons Suggestions & Single Word DNS Fallbacks
user_pref("browser.urlbar.addons.featureGate", false);
user_pref("browser.urlbar.clipboard.featureGate", false);
user_pref("browser.urlbar.dnsResolveSingleWordsAfterSearch", 0);
user_pref("browser.urlbar.fakespot.featureGate", false);
user_pref("browser.urlbar.mdn.featureGate", false);

// Merino Engine Endpoint & OHTTP Query Anonymization Proxy Tunnels
user_pref("browser.urlbar.merino.endpointURL", "");
user_pref("browser.urlbar.merino.ohttpConfigURL", "");
user_pref("browser.urlbar.merino.ohttpRelayURL", "");
user_pref("browser.urlbar.openViewOnFocus", false);
user_pref("browser.urlbar.pocket.featureGate", false);

// QuickSuggest Partner Content Matching Algorithms
user_pref("browser.urlbar.quicksuggest.ampMatchingStrategy", 0);
user_pref("browser.urlbar.quicksuggest.ampTopPickCharThreshold", 0);
user_pref("browser.urlbar.quicksuggest.contextualOptIn", false);
user_pref("browser.urlbar.quicksuggest.contextualOptIn.sayHello", false);
user_pref("browser.urlbar.quicksuggest.dataCollection.enabled", false);
user_pref("browser.urlbar.quicksuggest.mlEnabled", false);
user_pref("browser.urlbar.quicksuggest.online.available", false);
user_pref("browser.urlbar.quicksuggest.shouldShowOnboardingDialog", false);
user_pref("browser.urlbar.quicksuggest.sponsoredIndex", -1);

// Urlbar Context Suggest Overrides & Third Party Telemetry Drops
user_pref("browser.urlbar.recentsearches.featureGate", false);
user_pref("browser.urlbar.scotchBonnet.enableOverride", false);
user_pref("browser.urlbar.showSearchSuggestionsFirst", false);
user_pref("browser.urlbar.showSearchTerms.enabled", false);
user_pref("browser.urlbar.suggest.engines", false);
user_pref("browser.urlbar.suggest.fakespot", false);
user_pref("browser.urlbar.suggest.pocket", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.suggest.topsites", false);
user_pref("browser.urlbar.suggest.weather", false);
user_pref("browser.urlbar.suggest.yelp", false);
user_pref("browser.urlbar.trimURLs", false);
user_pref("browser.urlbar.weather.featureGate", false);
user_pref("browser.urlbar.yelp.featureGate", false);
user_pref("browser.urlbar.yelp.mlEnabled", false);

/****************************************************************************
 * SECTION: COMPONENT SANDBOXING & PRIVACY PIPELINES                       *
 ****************************************************************************/

// VPN Promos, Clipboard Leak Guards & Insecure Downloads
user_pref("browser.vpn_promo.enabled", false);
user_pref("clipboard.copyPrivateDataToClipboardCloudOrHistory", false);
user_pref("dom.block_download_insecure", false);

// Captive Portal Detection Subsystems
user_pref("captivedetect.canonicalURL", "");

// Decentralised Attribute Privacy (DAP) Proxy Configuration
user_pref("dap.ohttp.hpke", "");
user_pref("dap.ohttp.relayURL", "");

// Health Report Tracking Services
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("default-browser-agent.enabled", false);

// Self-XSS Developer Console Mitigations
user_pref("devtools.selfxss.count", 10);

// Lazy Media Loads & DNS Lookups For Anchor Documents
user_pref("dom.iframe_lazy_loading.enabled", false);
user_pref("dom.image-lazy-loading.enabled", false);
user_pref("dom.prefetch_dns_for_anchor_http_document", false);
user_pref("dom.prefetch_dns_for_anchor_https_document", false);

// Private Attribution Advertising Framework & Performance Shunts
user_pref("dom.private-attribution.submission.enabled", false);
user_pref("dom.security.unexpected_system_load_telemetry_enabled", false);

// WebGPU Process Pipelines & Service Workers Isolation
user_pref("dom.webgpu.enabled", false);
user_pref("dom.webgpu.service-workers.enabled", false);

// Web Push Notification Engines
user_pref("dom.webnotifications.enabled", false);
user_pref("dom.webnotifications.privateBrowsing.enabled", false);

// Experimental Extensions Features & Quarantined Domain Contexts
user_pref("extensions.experiments.enabled", false);
user_pref("extensions.formautofill.available", "off");
user_pref("extensions.pocket.api", "");
user_pref("extensions.pocket.enabled", false);
user_pref("extensions.pocket.site", "");
user_pref("extensions.quarantinedDomains.enabled", false);
user_pref("extensions.recommendations.hideNotice", true);
user_pref("extensions.webcompat.smartblockEmbeds.enabled", false);
user_pref("extensions.webextensions.restrictedDomains", "");

// General Setup Warning Flags
user_pref("general.warnOnAboutConfig", false);
user_pref("intl.accept_languages", "en-US, en");

/****************************************************************************
 * SECTION: MEDIA LAYER ENGINE ADJUSTMENTS                                  *
 ****************************************************************************/

// Keyframe Skip Decoders & Legacy Device Enumeration
user_pref("media.decoder.skip-to-next-key-frame.enabled", false);
user_pref("media.devices.enumerate.legacy.enabled", false);

// Background Video Playback Suspension Timers
user_pref("media.suspend-background-video.delay-ms", 900000);
user_pref("media.suspend-background-video.enabled", false);
user_pref("media.suspend-bkgnd-video.enabled", false);
user_pref("permissions.media.query.enabled", false);

/****************************************************************************
 * SECTION: NETWORK PREDICTOR, DNS OVER HTTPS (TRR) & PROTOCOLS             *
 ****************************************************************************/

// Remote Content Experiments Loader
user_pref("messaging-system.rsexperimentloader.collection_id", "");
user_pref("messaging-system.rsexperimentloader.enabled", false);

// Connectivity Service Mapping & Secure DNS Domain Rules
user_pref("network.connectivity-service.DNS_HTTPS.domain", "");
user_pref("network.dns.prefetch_via_proxy", false);

// HTTP Dictionary Support & Pipelined Connection Throttles
user_pref("network.http.dictionaries.enable", false);
user_pref("network.http.throttle.enable", false);

// Network Predictor Preconnections & Speculative Prefetch Systems
user_pref("network.preconnect", false);
user_pref("network.predictor.enabled", false);
user_pref("network.predictor.enable-prefetch", false);

// Trusted Recursive Resolver (DoH) Anonymized OHTTP Mode Enforcement
user_pref("network.trr.confirmation_telemetry_enabled", false);
user_pref("network.trr.mode", 5);
user_pref("network.trr.ohttp.config_uri", "");
user_pref("network.trr.ohttp.relay_uri", "");
user_pref("network.trr.ohttp.uri", "");
user_pref("network.trr.use_ohttp", false);

/****************************************************************************
 * SECTION: NIMBUS EXPERIMENTATION FRAMEWORK DISABLES                       *
 ****************************************************************************/

// Deployment Rollouts, Validation Checking & Targeting Telemetry
user_pref("nimbus.debug", false);
user_pref("nimbus.profilesdatastoreservice.enabled", false);
user_pref("nimbus.profilesdatastoreservice.read.enabled", false);
user_pref("nimbus.profilesdatastoreservice.sync.enabled", false);
user_pref("nimbus.rollouts.enabled", false);
user_pref("nimbus.telemetry.targetingContextEnabled", false);
user_pref("nimbus.validation.enabled", false);

/****************************************************************************
 * SECTION: PDF VIEWING ENGINE OPTIMISATIONS                                *
 ****************************************************************************/

// PDF Viewer Accessibility Meta Text Download Channels
user_pref("pdfjs.enableAltTextModelDownload", false);
user_pref("pdfjs.enableGuessAltText", false);
user_pref("pdfjs.enableML", false);
user_pref("pdfjs.enableNewAltTextWhenAddingImage", false);

/****************************************************************************
 * SECTION: FINGERPRINTING & CROSS-ORIGIN LINKABILITY MECHANISMS            *
 ****************************************************************************/

// High Threat Model Fingerprinting Protections (FPP Overrides)
user_pref("privacy.fingerprintingProtection", true);
user_pref("privacy.fingerprintingProtection.pbmode", true);
user_pref("privacy.fingerprintingProtection.remoteOverrides.enabled", false);
user_pref("privacy.fingerprintingProtection.overrides", "-AllTargets,+CSSDeviceSize,+ScreenAvailRect,+ScreenRect,+WindowOuterSize,+CanvasRandomization,+FontVisibilityBaseSystem,+MediaDevices,+SpeechSynthesis,+WebGLRenderInfo,+JSLocale,+NavigatorHWConcurrency");
user_pref("privacy.wallet_schemes", "");

/****************************************************************************
 * SECTION: ADVANCED CRYPTO TLS HARDENING & ROOT CERTIFICATE VALIDATION     *
 ****************************************************************************/

// MitM Enterprise Roots Integration & Intercept Warning Delay Overrides
user_pref("security.certerrors.mitm.auto_enable_enterprise_roots", false);
user_pref("security.certerrors.permanentOverride", false);
user_pref("security.dialog_enable_delay", 0);
user_pref("security.enterprise_roots.enabled", false);
user_pref("security.family_safety.mode", 0);

// Insecure Connection Context Labels
user_pref("security.insecure_connection_text.enabled", false);
user_pref("security.insecure_connection_text.pbmode.enabled", false);

// TLS Session False Start & Safe Handshake Negotiation Rules
user_pref("security.ssl.enable_false_start", false);
user_pref("security.ssl.require_safe_negotiation", true);

// Post-Quantum Hybrid Cryptography (Kyber Key Exchange) Pipelines
user_pref("security.tls.enable_certificate_compression_abridged", true);
user_pref("security.tls.enable_kyber", true);
user_pref("security.tls.version.enable-deprecated", false);

/****************************************************************************
 * SECTION: USER INTERFACE LAYOUTS, SYNC REGULATION & ACCESSIBILITY        *
 ****************************************************************************/

// Structural Workspace Sidebar Render Mechanics
user_pref("sidebar.animation.duration-ms", 0);
user_pref("sidebar.main.tools", "");
user_pref("sidebar.verticalTabs", false);
user_pref("sidebar.visibility", "hide-sidebar");

// User Agreement Logs & System Pref Migrations Checks
user_pref("startup.homepage_override_nimbus_disable_wnp", true);
user_pref("termsofuse.acceptedDate", "1900000000000");
user_pref("termsofuse.acceptedVersion", 9999);

// Shopping Review Tooling Network Targets
user_pref("toolkit.shopping.environment", "");
user_pref("toolkit.shopping.experience2023.defr", false);
user_pref("toolkit.shopping.ohttpConfigURL", "");
user_pref("toolkit.shopping.ohttpRelayURL", "");

// Decentralised Attribute Privacy (DAP) Telemetry Nodes Blockers
user_pref("toolkit.telemetry.dap_enabled", false);
user_pref("toolkit.telemetry.dap_helper", "");
user_pref("toolkit.telemetry.dap.helper.hpke", "");
user_pref("toolkit.telemetry.dap_helper_owner", "");
user_pref("toolkit.telemetry.dap.helper.url", "");
user_pref("toolkit.telemetry.dap_leader", "");
user_pref("toolkit.telemetry.dap.leader.hpke", "");
user_pref("toolkit.telemetry.dap_leader_owner", "");
user_pref("toolkit.telemetry.dap.leader.url", "");
user_pref("toolkit.telemetry.dap_task1_enabled", false);
user_pref("toolkit.telemetry.dap_visit_counting_enabled", false);
user_pref("toolkit.telemetry.dap_visit_counting_experiment_list", "[]");
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("toolkit.telemetry.shutdownPingSender.backgroundtask.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabledFirstSession", false);
user_pref("toolkit.telemetry.user_characteristics_ping.opt-out", true);

// Accessibility Text Carat Blink Frequency
user_pref("ui.caretBlinkCount", -1);

/****************************************************************************
 * SECTION: WINDOW OCCLUSION TRACKING & BACKGROUND SHUNTS                   *
 ****************************************************************************/

// Windows OS Native Background Occlusion Analytics Toggles
user_pref("widget.windows.window_occlusion_tracking.enabled", false);
user_pref("widget.windows.window_occlusion_tracking_display_state.enabled", false);
user_pref("widget.windows.window_occlusion_tracking_session_lock.enabled", false);

/****************************************************************************
 * SECTION: IDENTITY REGISTRY SERVICES & TELEMETRY                          *
 ****************************************************************************/

// Firefox Accounts Cloud Profile Diagnostic Client Pings
user_pref("identity.fxaccounts.telemetry.clientAssociationPing.enabled", false);

/****************************************************************************
 * SECTION: EXPERIMENTAL DATA PLATFORMS & NEWTAB WEATHER SYSTEMS             *
 ****************************************************************************/

// Nova Workspace Interface Layout Engine
user_pref("browser.newtabpage.activity-stream.nova.enabled", false);

// Weather Forecast Data Endpoints & Telemetry Feedback Hooks
user_pref("browser.newtabpage.activity-stream.weather.hourlyEndpoint", "");
user_pref("browser.newtabpage.activity-stream.weather.reportEndpoint", "");
user_pref("browser.newtabpage.activity-stream.widgets.feedback.enabled", false);

// History Memory Context Scraping Features
user_pref("browser.smartwindow.memories.generateFromHistory", false);
user_pref("browser.smartwindow.nova.enabled", false);

// World Cup Promotional Sport Telemetry Stream Widgets
user_pref("browser.smartwindow.worldcup.enabled", false);
user_pref("browser.smartwindow.worldcup.endpointURL", "");

/****************************************************************************
 * SECTION: URLBAR SUGGESTIONS, NO PRECONNECTS & SEARCH HOOKS                *
 ****************************************************************************/

// Merino Dynamic Weather Service Suggestion Aggregators
user_pref("browser.urlbar.merino.weather.hourlyEndpointURL", "");
user_pref("browser.urlbar.merino.weather.reportEndpointURL", "");

// Nova Feature Gates, Suggestion Result Rationale Disables & Preconnects
user_pref("browser.urlbar.nova.featureGate", false);
user_pref("browser.urlbar.quicksuggest.ampTopPickUseNovaIconSize", false);
user_pref("browser.urlbar.resultExplanations.featureGate", false);
user_pref("network.trr.preconnect_on_foreground", false);

// Clean Search Field Shortcuts
user_pref("browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts", false);

/****************************************************************************
 * END: BETTERFOX                                                           *
 ****************************************************************************/
