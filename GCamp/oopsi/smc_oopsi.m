




<!DOCTYPE html>
<html class="   ">
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# object: http://ogp.me/ns/object# article: http://ogp.me/ns/article# profile: http://ogp.me/ns/profile#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    
    <title>smc-oopsi/code/functions/smc_oopsi.m at master · jovo/smc-oopsi · GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-144.png" />
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144.png" />
    <meta property="fb:app_id" content="1401488693436528"/>

      <meta content="@github" name="twitter:site" /><meta content="summary" name="twitter:card" /><meta content="jovo/smc-oopsi" name="twitter:title" /><meta content="smc-oopsi - code to implement our sequential monte carlo (smc) algorithm to perform optimal optical spike inference (oopsi) for individual neurons" name="twitter:description" /><meta content="https://avatars1.githubusercontent.com/u/41842?s=400" name="twitter:image:src" />
<meta content="GitHub" property="og:site_name" /><meta content="object" property="og:type" /><meta content="https://avatars1.githubusercontent.com/u/41842?s=400" property="og:image" /><meta content="jovo/smc-oopsi" property="og:title" /><meta content="https://github.com/jovo/smc-oopsi" property="og:url" /><meta content="smc-oopsi - code to implement our sequential monte carlo (smc) algorithm to perform optimal optical spike inference (oopsi) for individual neurons" property="og:description" />

    <link rel="assets" href="https://assets-cdn.github.com/">
    <link rel="conduit-xhr" href="https://ghconduit.com:25035">
    

    <meta name="msapplication-TileImage" content="/windows-tile.png" />
    <meta name="msapplication-TileColor" content="#ffffff" />
    <meta name="selected-link" value="repo_source" data-pjax-transient />
      <meta name="google-analytics" content="UA-3769691-2">

    <meta content="collector.githubapp.com" name="octolytics-host" /><meta content="collector-cdn.github.com" name="octolytics-script-host" /><meta content="github" name="octolytics-app-id" /><meta content="80C551D4:475F:23C8E4A:5395B49C" name="octolytics-dimension-request_id" />
    

    
    
    <link rel="icon" type="image/x-icon" href="https://assets-cdn.github.com/favicon.ico" />


    <meta content="authenticity_token" name="csrf-param" />
<meta content="hC+M064Lof/JrxTWUKxCJLa5fzeWflx+avl5GXt+k4RNvD9Rog3DojnRApyuiuj1lBNooT0rvyXAyZOBreyWwQ==" name="csrf-token" />

    <link href="https://assets-cdn.github.com/assets/github-1aeb426322c64c12b92d56bda5b110fc1093f75e.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://assets-cdn.github.com/assets/github2-b2cccfcac1a522b6ce675606f61388d36bf2c080.css" media="all" rel="stylesheet" type="text/css" />
    


    <meta http-equiv="x-pjax-version" content="6b9e40027b6fe719e1c3d0a9180a2d6a">

      
  <meta name="description" content="smc-oopsi - code to implement our sequential monte carlo (smc) algorithm to perform optimal optical spike inference (oopsi) for individual neurons" />

  <meta content="41842" name="octolytics-dimension-user_id" /><meta content="jovo" name="octolytics-dimension-user_login" /><meta content="94644" name="octolytics-dimension-repository_id" /><meta content="jovo/smc-oopsi" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="false" name="octolytics-dimension-repository_is_fork" /><meta content="94644" name="octolytics-dimension-repository_network_root_id" /><meta content="jovo/smc-oopsi" name="octolytics-dimension-repository_network_root_nwo" />
  <link href="https://github.com/jovo/smc-oopsi/commits/master.atom" rel="alternate" title="Recent Commits to smc-oopsi:master" type="application/atom+xml" />

  </head>


  <body class="logged_out  env-production windows vis-public page-blob">
    <a href="#start-of-content" tabindex="1" class="accessibility-aid js-skip-to-content">Skip to content</a>
    <div class="wrapper">
      
      
      
      


      
      <div class="header header-logged-out">
  <div class="container clearfix">

    <a class="header-logo-wordmark" href="https://github.com/">
      <span class="mega-octicon octicon-logo-github"></span>
    </a>

    <div class="header-actions">
        <a class="button primary" href="/join">Sign up</a>
      <a class="button signin" href="/login?return_to=%2Fjovo%2Fsmc-oopsi%2Fblob%2Fmaster%2Fcode%2Ffunctions%2Fsmc_oopsi.m">Sign in</a>
    </div>

    <div class="command-bar js-command-bar  in-repository">

      <ul class="top-nav">
          <li class="explore"><a href="/explore">Explore</a></li>
        <li class="features"><a href="/features">Features</a></li>
          <li class="enterprise"><a href="https://enterprise.github.com/">Enterprise</a></li>
          <li class="blog"><a href="/blog">Blog</a></li>
      </ul>
        <form accept-charset="UTF-8" action="/search" class="command-bar-form" id="top_search_form" method="get">

<div class="commandbar">
  <span class="message"></span>
  <input type="text" data-hotkey="s, /" name="q" id="js-command-bar-field" placeholder="Search or type a command" tabindex="1" autocapitalize="off"
    
    
      data-repo="jovo/smc-oopsi"
      data-branch="master"
      data-sha="eededdba75cdb66aa1fe9b33e960f73ed5db4ee1"
  >
  <div class="display hidden"></div>
</div>

    <input type="hidden" name="nwo" value="jovo/smc-oopsi" />

    <div class="select-menu js-menu-container js-select-menu search-context-select-menu">
      <span class="minibutton select-menu-button js-menu-target" role="button" aria-haspopup="true">
        <span class="js-select-button">This repository</span>
      </span>

      <div class="select-menu-modal-holder js-menu-content js-navigation-container" aria-hidden="true">
        <div class="select-menu-modal">

          <div class="select-menu-item js-navigation-item js-this-repository-navigation-item selected">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" class="js-search-this-repository" name="search_target" value="repository" checked="checked" />
            <div class="select-menu-item-text js-select-button-text">This repository</div>
          </div> <!-- /.select-menu-item -->

          <div class="select-menu-item js-navigation-item js-all-repositories-navigation-item">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" name="search_target" value="global" />
            <div class="select-menu-item-text js-select-button-text">All repositories</div>
          </div> <!-- /.select-menu-item -->

        </div>
      </div>
    </div>

  <span class="help tooltipped tooltipped-s" aria-label="Show command bar help">
    <span class="octicon octicon-question"></span>
  </span>


  <input type="hidden" name="ref" value="cmdform">

</form>
    </div>

  </div>
</div>



      <div id="start-of-content" class="accessibility-aid"></div>
          <div class="site" itemscope itemtype="http://schema.org/WebPage">
    <div id="js-flash-container">
      
    </div>
    <div class="pagehead repohead instapaper_ignore readability-menu">
      <div class="container">
        

<ul class="pagehead-actions">


  <li>
    <a href="/login?return_to=%2Fjovo%2Fsmc-oopsi"
    class="minibutton with-count star-button tooltipped tooltipped-n"
    aria-label="You must be signed in to star a repository" rel="nofollow">
    <span class="octicon octicon-star"></span>Star
  </a>

    <a class="social-count js-social-count" href="/jovo/smc-oopsi/stargazers">
      11
    </a>

  </li>

    <li>
      <a href="/login?return_to=%2Fjovo%2Fsmc-oopsi"
        class="minibutton with-count js-toggler-target fork-button tooltipped tooltipped-n"
        aria-label="You must be signed in to fork a repository" rel="nofollow">
        <span class="octicon octicon-repo-forked"></span>Fork
      </a>
      <a href="/jovo/smc-oopsi/network" class="social-count">
        3
      </a>
    </li>
</ul>

        <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
          <span class="repo-label"><span>public</span></span>
          <span class="mega-octicon octicon-repo"></span>
          <span class="author"><a href="/jovo" class="url fn" itemprop="url" rel="author"><span itemprop="title">jovo</span></a></span><!--
       --><span class="path-divider">/</span><!--
       --><strong><a href="/jovo/smc-oopsi" class="js-current-repository js-repo-home-link">smc-oopsi</a></strong>

          <span class="page-context-loader">
            <img alt="" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
          </span>

        </h1>
      </div><!-- /.container -->
    </div><!-- /.repohead -->

    <div class="container">
      <div class="repository-with-sidebar repo-container new-discussion-timeline js-new-discussion-timeline  ">
        <div class="repository-sidebar clearfix">
            

<div class="sunken-menu vertical-right repo-nav js-repo-nav js-repository-container-pjax js-octicon-loaders">
  <div class="sunken-menu-contents">
    <ul class="sunken-menu-group">
      <li class="tooltipped tooltipped-w" aria-label="Code">
        <a href="/jovo/smc-oopsi" aria-label="Code" class="selected js-selected-navigation-item sunken-menu-item" data-hotkey="g c" data-pjax="true" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches /jovo/smc-oopsi">
          <span class="octicon octicon-code"></span> <span class="full-word">Code</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

        <li class="tooltipped tooltipped-w" aria-label="Issues">
          <a href="/jovo/smc-oopsi/issues" aria-label="Issues" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g i" data-selected-links="repo_issues /jovo/smc-oopsi/issues">
            <span class="octicon octicon-issue-opened"></span> <span class="full-word">Issues</span>
            <span class='counter'>5</span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>

      <li class="tooltipped tooltipped-w" aria-label="Pull Requests">
        <a href="/jovo/smc-oopsi/pulls" aria-label="Pull Requests" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g p" data-selected-links="repo_pulls /jovo/smc-oopsi/pulls">
            <span class="octicon octicon-git-pull-request"></span> <span class="full-word">Pull Requests</span>
            <span class='counter'>0</span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>


        <li class="tooltipped tooltipped-w" aria-label="Wiki">
          <a href="/jovo/smc-oopsi/wiki" aria-label="Wiki" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g w" data-selected-links="repo_wiki /jovo/smc-oopsi/wiki">
            <span class="octicon octicon-book"></span> <span class="full-word">Wiki</span>
            <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>
    </ul>
    <div class="sunken-menu-separator"></div>
    <ul class="sunken-menu-group">

      <li class="tooltipped tooltipped-w" aria-label="Pulse">
        <a href="/jovo/smc-oopsi/pulse" aria-label="Pulse" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="pulse /jovo/smc-oopsi/pulse">
          <span class="octicon octicon-pulse"></span> <span class="full-word">Pulse</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped tooltipped-w" aria-label="Graphs">
        <a href="/jovo/smc-oopsi/graphs" aria-label="Graphs" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="repo_graphs repo_contributors /jovo/smc-oopsi/graphs">
          <span class="octicon octicon-graph"></span> <span class="full-word">Graphs</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped tooltipped-w" aria-label="Network">
        <a href="/jovo/smc-oopsi/network" aria-label="Network" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-selected-links="repo_network /jovo/smc-oopsi/network">
          <span class="octicon octicon-repo-forked"></span> <span class="full-word">Network</span>
          <img alt="" class="mini-loader" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>
    </ul>


  </div>
</div>

              <div class="only-with-full-nav">
                

  

<div class="clone-url open"
  data-protocol-type="http"
  data-url="/users/set_protocol?protocol_selector=http&amp;protocol_type=clone">
  <h3><strong>HTTPS</strong> clone URL</h3>
  <div class="clone-url-box">
    <input type="text" class="clone js-url-field"
           value="https://github.com/jovo/smc-oopsi.git" readonly="readonly">
    <span class="url-box-clippy">
    <button aria-label="copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/jovo/smc-oopsi.git" data-copied-hint="copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  

<div class="clone-url "
  data-protocol-type="subversion"
  data-url="/users/set_protocol?protocol_selector=subversion&amp;protocol_type=clone">
  <h3><strong>Subversion</strong> checkout URL</h3>
  <div class="clone-url-box">
    <input type="text" class="clone js-url-field"
           value="https://github.com/jovo/smc-oopsi" readonly="readonly">
    <span class="url-box-clippy">
    <button aria-label="copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/jovo/smc-oopsi" data-copied-hint="copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>


<p class="clone-options">You can clone with
      <a href="#" class="js-clone-selector" data-protocol="http">HTTPS</a>
      or <a href="#" class="js-clone-selector" data-protocol="subversion">Subversion</a>.
  <span class="help tooltipped tooltipped-n" aria-label="Get help on which URL is right for you.">
    <a href="https://help.github.com/articles/which-remote-url-should-i-use">
    <span class="octicon octicon-question"></span>
    </a>
  </span>
</p>


  <a href="http://windows.github.com" class="minibutton sidebar-button" title="Save jovo/smc-oopsi to your computer and use it in GitHub Desktop." aria-label="Save jovo/smc-oopsi to your computer and use it in GitHub Desktop.">
    <span class="octicon octicon-device-desktop"></span>
    Clone in Desktop
  </a>

                <a href="/jovo/smc-oopsi/archive/master.zip"
                   class="minibutton sidebar-button"
                   aria-label="Download jovo/smc-oopsi as a zip file"
                   title="Download jovo/smc-oopsi as a zip file"
                   rel="nofollow">
                  <span class="octicon octicon-cloud-download"></span>
                  Download ZIP
                </a>
              </div>
        </div><!-- /.repository-sidebar -->

        <div id="js-repo-pjax-container" class="repository-content context-loader-container" data-pjax-container>
          


<a href="/jovo/smc-oopsi/blob/61580a95ca1264620030385947f4aae7625334df/code/functions/smc_oopsi.m" class="hidden js-permalink-shortcut" data-hotkey="y">Permalink</a>

<!-- blob contrib key: blob_contributors:v21:d1fdb2e96b3163667fe4a494eb65fcb9 -->

<p title="This is a placeholder element" class="js-history-link-replace hidden"></p>

<a href="/jovo/smc-oopsi/find/master" data-pjax data-hotkey="t" class="js-show-file-finder" style="display:none">Show File Finder</a>

<div class="file-navigation">
  

<div class="select-menu js-menu-container js-select-menu" >
  <span class="minibutton select-menu-button js-menu-target" data-hotkey="w"
    data-master-branch="master"
    data-ref="master"
    role="button" aria-label="Switch branches or tags" tabindex="0" aria-haspopup="true">
    <span class="octicon octicon-git-branch"></span>
    <i>branch:</i>
    <span class="js-select-button">master</span>
  </span>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax aria-hidden="true">

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <span class="select-menu-title">Switch branches/tags</span>
        <span class="octicon octicon-x js-menu-close"></span>
      </div> <!-- /.select-menu-header -->

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Filter branches/tags" id="context-commitish-filter-field" class="js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" class="js-select-menu-tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" class="js-select-menu-tab">Tags</a>
            </li>
          </ul>
        </div><!-- /.select-menu-tabs -->
      </div><!-- /.select-menu-filters -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/jovo/smc-oopsi/blob/branch_yu/code/functions/smc_oopsi.m"
                 data-name="branch_yu"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target"
                 title="branch_yu">branch_yu</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/jovo/smc-oopsi/blob/gh-pages/code/functions/smc_oopsi.m"
                 data-name="gh-pages"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target"
                 title="gh-pages">gh-pages</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item selected">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/jovo/smc-oopsi/blob/master/code/functions/smc_oopsi.m"
                 data-name="master"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target"
                 title="master">master</a>
            </div> <!-- /.select-menu-item -->
        </div>

          <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/jovo/smc-oopsi/tree/v0.1/code/functions/smc_oopsi.m"
                 data-name="v0.1"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target"
                 title="v0.1">v0.1</a>
            </div> <!-- /.select-menu-item -->
        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

    </div> <!-- /.select-menu-modal -->
  </div> <!-- /.select-menu-modal-holder -->
</div> <!-- /.select-menu -->

  <div class="breadcrumb">
    <span class='repo-root js-repo-root'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/jovo/smc-oopsi" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">smc-oopsi</span></a></span></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/jovo/smc-oopsi/tree/master/code" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">code</span></a></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/jovo/smc-oopsi/tree/master/code/functions" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">functions</span></a></span><span class="separator"> / </span><strong class="final-path">smc_oopsi.m</strong> <button aria-label="copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="code/functions/smc_oopsi.m" data-copied-hint="copied!" type="button"><span class="octicon octicon-clippy"></span></button>
  </div>
</div>


  <div class="commit file-history-tease">
      <img alt="joshua vogelstein" class="main-avatar js-avatar" data-user="41842" height="24" src="https://avatars2.githubusercontent.com/u/41842?s=140" width="24" />
      <span class="author"><a href="/jovo" rel="author">jovo</a></span>
      <time datetime="2010-02-09T13:48:09-05:00" is="relative-time">February 09, 2010</time>
      <div class="commit-title">
          <a href="/jovo/smc-oopsi/commit/53c3e68898741fa9dbe9b3153a95aae669606c82" class="message" data-pjax="true" title="fixed smc-oopsi bugs and works with poopsi now">fixed smc-oopsi bugs and works with poopsi now</a>
      </div>

    <div class="participation">
      <p class="quickstat"><a href="#blob_contributors_box" rel="facebox"><strong>1</strong>  contributor</a></p>
      
    </div>
    <div id="blob_contributors_box" style="display:none">
      <h2 class="facebox-header">Users who have contributed to this file</h2>
      <ul class="facebox-user-list">
          <li class="facebox-user-list-item">
            <img alt="joshua vogelstein" class=" js-avatar" data-user="41842" height="24" src="https://avatars2.githubusercontent.com/u/41842?s=140" width="24" />
            <a href="/jovo">jovo</a>
          </li>
      </ul>
    </div>
  </div>

<div class="file-box">
  <div class="file">
    <div class="meta clearfix">
      <div class="info file-name">
        <span class="icon"><b class="octicon octicon-file-text"></b></span>
        <span class="mode" title="File Mode">executable file</span>
        <span class="meta-divider"></span>
          <span>94 lines (86 sloc)</span>
          <span class="meta-divider"></span>
        <span>5.106 kb</span>
      </div>
      <div class="actions">
        <div class="button-group">
            <a class="minibutton tooltipped tooltipped-w"
               href="http://windows.github.com" aria-label="Open this file in GitHub for Windows">
                <span class="octicon octicon-device-desktop"></span> Open
            </a>
              <a class="minibutton disabled tooltipped tooltipped-w" href="#"
                 aria-label="You must be signed in to make or propose changes">Edit</a>
          <a href="/jovo/smc-oopsi/raw/master/code/functions/smc_oopsi.m" class="button minibutton " id="raw-url">Raw</a>
            <a href="/jovo/smc-oopsi/blame/master/code/functions/smc_oopsi.m" class="button minibutton js-update-url-with-hash">Blame</a>
          <a href="/jovo/smc-oopsi/commits/master/code/functions/smc_oopsi.m" class="button minibutton " rel="nofollow">History</a>
        </div><!-- /.button-group -->
          <a class="minibutton danger disabled empty-icon tooltipped tooltipped-w" href="#"
             aria-label="You must be signed in to make or propose changes">
          Delete
        </a>
      </div><!-- /.actions -->
    </div>
      
  <div class="blob-wrapper data type-m js-blob-data">
       <table class="file-code file-diff tab-size-8">
         <tr class="file-code-line">
           <td class="blob-line-nums">
             <span id="L1" rel="#L1">1</span>
<span id="L2" rel="#L2">2</span>
<span id="L3" rel="#L3">3</span>
<span id="L4" rel="#L4">4</span>
<span id="L5" rel="#L5">5</span>
<span id="L6" rel="#L6">6</span>
<span id="L7" rel="#L7">7</span>
<span id="L8" rel="#L8">8</span>
<span id="L9" rel="#L9">9</span>
<span id="L10" rel="#L10">10</span>
<span id="L11" rel="#L11">11</span>
<span id="L12" rel="#L12">12</span>
<span id="L13" rel="#L13">13</span>
<span id="L14" rel="#L14">14</span>
<span id="L15" rel="#L15">15</span>
<span id="L16" rel="#L16">16</span>
<span id="L17" rel="#L17">17</span>
<span id="L18" rel="#L18">18</span>
<span id="L19" rel="#L19">19</span>
<span id="L20" rel="#L20">20</span>
<span id="L21" rel="#L21">21</span>
<span id="L22" rel="#L22">22</span>
<span id="L23" rel="#L23">23</span>
<span id="L24" rel="#L24">24</span>
<span id="L25" rel="#L25">25</span>
<span id="L26" rel="#L26">26</span>
<span id="L27" rel="#L27">27</span>
<span id="L28" rel="#L28">28</span>
<span id="L29" rel="#L29">29</span>
<span id="L30" rel="#L30">30</span>
<span id="L31" rel="#L31">31</span>
<span id="L32" rel="#L32">32</span>
<span id="L33" rel="#L33">33</span>
<span id="L34" rel="#L34">34</span>
<span id="L35" rel="#L35">35</span>
<span id="L36" rel="#L36">36</span>
<span id="L37" rel="#L37">37</span>
<span id="L38" rel="#L38">38</span>
<span id="L39" rel="#L39">39</span>
<span id="L40" rel="#L40">40</span>
<span id="L41" rel="#L41">41</span>
<span id="L42" rel="#L42">42</span>
<span id="L43" rel="#L43">43</span>
<span id="L44" rel="#L44">44</span>
<span id="L45" rel="#L45">45</span>
<span id="L46" rel="#L46">46</span>
<span id="L47" rel="#L47">47</span>
<span id="L48" rel="#L48">48</span>
<span id="L49" rel="#L49">49</span>
<span id="L50" rel="#L50">50</span>
<span id="L51" rel="#L51">51</span>
<span id="L52" rel="#L52">52</span>
<span id="L53" rel="#L53">53</span>
<span id="L54" rel="#L54">54</span>
<span id="L55" rel="#L55">55</span>
<span id="L56" rel="#L56">56</span>
<span id="L57" rel="#L57">57</span>
<span id="L58" rel="#L58">58</span>
<span id="L59" rel="#L59">59</span>
<span id="L60" rel="#L60">60</span>
<span id="L61" rel="#L61">61</span>
<span id="L62" rel="#L62">62</span>
<span id="L63" rel="#L63">63</span>
<span id="L64" rel="#L64">64</span>
<span id="L65" rel="#L65">65</span>
<span id="L66" rel="#L66">66</span>
<span id="L67" rel="#L67">67</span>
<span id="L68" rel="#L68">68</span>
<span id="L69" rel="#L69">69</span>
<span id="L70" rel="#L70">70</span>
<span id="L71" rel="#L71">71</span>
<span id="L72" rel="#L72">72</span>
<span id="L73" rel="#L73">73</span>
<span id="L74" rel="#L74">74</span>
<span id="L75" rel="#L75">75</span>
<span id="L76" rel="#L76">76</span>
<span id="L77" rel="#L77">77</span>
<span id="L78" rel="#L78">78</span>
<span id="L79" rel="#L79">79</span>
<span id="L80" rel="#L80">80</span>
<span id="L81" rel="#L81">81</span>
<span id="L82" rel="#L82">82</span>
<span id="L83" rel="#L83">83</span>
<span id="L84" rel="#L84">84</span>
<span id="L85" rel="#L85">85</span>
<span id="L86" rel="#L86">86</span>
<span id="L87" rel="#L87">87</span>
<span id="L88" rel="#L88">88</span>
<span id="L89" rel="#L89">89</span>
<span id="L90" rel="#L90">90</span>
<span id="L91" rel="#L91">91</span>
<span id="L92" rel="#L92">92</span>
<span id="L93" rel="#L93">93</span>
<span id="L94" rel="#L94">94</span>

           </td>
           <td class="blob-line-code"><div class="code-body highlight"><pre><div class='line' id='LC1'><span class="k">function</span> <span class="nv">[M</span> <span class="nv">P</span> <span class="nv">V]</span> <span class="nb">=</span> <span class="nv">smc_oopsi</span><span class="p">(</span><span class="nv">F,V,P</span><span class="p">)</span></div><div class='line' id='LC2'><span class="nv">%</span> <span class="nv">this</span> <span class="k">function</span> <span class="nv">runs</span> <span class="k">the</span> <span class="nv">SMC-EM</span> <span class="nv">on</span> <span class="nv">a</span> <span class="nv">fluorescence</span> <span class="nv">time-series,</span> <span class="nb">and</span> <span class="nv">outputs</span> <span class="k">the</span> <span class="nv">inferred</span></div><div class='line' id='LC3'><span class="nv">%</span> <span class="nv">distributions</span> <span class="nb">and</span> <span class="nv">parameter</span> <span class="nv">estimates</span></div><div class='line' id='LC4'><span class="nv">%</span></div><div class='line' id='LC5'><span class="nv">%</span> <span class="nv">Inputs</span></div><div class='line' id='LC6'><span class="nv">%</span> <span class="nv">F:</span> <span class="nv">fluorescence</span> <span class="nb">time</span> <span class="nv">series</span></div><div class='line' id='LC7'><span class="nv">%</span> <span class="nv">V:</span> <span class="nv">structure</span> <span class="nv">of</span> <span class="nv">stuff</span> <span class="nv">necessary</span> <span class="nv">to</span> <span class="nv">run</span> <span class="nv">smc-em</span> <span class="nv">code</span></div><div class='line' id='LC8'><span class="nv">%</span> <span class="nv">P:</span> <span class="nv">structure</span> <span class="nv">of</span> <span class="nv">initial</span> <span class="nv">parameter</span> <span class="nv">estimates</span></div><div class='line' id='LC9'><span class="nv">%</span></div><div class='line' id='LC10'><span class="nv">%</span> <span class="nv">Outputs</span></div><div class='line' id='LC11'><span class="nv">%</span> <span class="nv">M:</span> <span class="nv">structure</span> <span class="nv">containing</span> <span class="nv">mean,</span> <span class="nv">variance,</span> <span class="nb">and</span> <span class="nv">percentiles</span> <span class="nv">of</span> <span class="nv">inferred</span> <span class="nv">distributions</span></div><div class='line' id='LC12'><span class="nv">%</span> <span class="nv">P:</span> <span class="nv">structure</span> <span class="nv">containing</span> <span class="k">the</span> <span class="nv">final</span> <span class="nv">parameter</span> <span class="nv">estimates</span></div><div class='line' id='LC13'><span class="nv">%</span> <span class="nv">V:</span> <span class="nv">structure</span> <span class="nv">Variables</span> <span class="nv">for</span> <span class="nv">algorithm</span> <span class="nv">to</span> <span class="nv">run</span></div><div class='line' id='LC14'><br/></div><div class='line' id='LC15'><span class="k">if</span> <span class="nv">nargin</span> <span class="nb">&lt;</span> <span class="mi">2</span><span class="o">,</span>          <span class="nv">V</span>       <span class="nb">=</span> <span class="nv">struct</span><span class="c1">;       end</span></div><div class='line' id='LC16'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;T</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>     <span class="nv">V.T</span>     <span class="nb">=</span> <span class="nb">length</span><span class="p">(</span><span class="nv">F</span><span class="p">)</span><span class="c1">;    end     % # of observations</span></div><div class='line' id='LC17'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;freq</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>  <span class="nv">V.freq</span>  <span class="nb">=</span> <span class="mi">1</span><span class="c1">;            end     % # time steps between observations</span></div><div class='line' id='LC18'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;T_o</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>   <span class="nv">V.T_o</span>   <span class="nb">=</span> <span class="nv">V.T</span><span class="c1">;          end     % # of observations</span></div><div class='line' id='LC19'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;x</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>     <span class="nv">V.x</span>     <span class="nb">=</span> <span class="nv">ones</span><span class="p">(</span><span class="mi">1</span><span class="o">,</span><span class="nv">V.T</span><span class="p">)</span><span class="c1">;  end     % stimulus</span></div><div class='line' id='LC20'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;scan</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>  <span class="nv">V.scan</span>  <span class="nb">=</span> <span class="mi">0</span><span class="c1">;            end     % epi or scan</span></div><div class='line' id='LC21'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;name</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>  <span class="nv">V.name</span>  <span class="nb">=</span><span class="ss">&#39;oopsi</span><span class="o">&#39;</span><span class="c1">;       end     % name for output and figure</span></div><div class='line' id='LC22'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;Nparticles</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>	<span class="nv">V.Nparticles</span>    <span class="nb">=</span> <span class="mi">99</span><span class="c1">; 	end % # particles</span></div><div class='line' id='LC23'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;Nspikehist</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>    <span class="nv">V.Nspikehist</span>	<span class="nb">=</span> <span class="mi">0</span><span class="c1">; 	end % # of spike history terms</span></div><div class='line' id='LC24'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;condsamp</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>    	<span class="nv">V.condsamp</span> 		<span class="nb">=</span> <span class="mi">1</span><span class="c1">;    end % whether to use conditional sampler</span></div><div class='line' id='LC25'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;ignorelik</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>  	<span class="nv">V.ignorelik</span>		<span class="nb">=</span> <span class="mi">1</span><span class="c1">; 	end % epi or scan</span></div><div class='line' id='LC26'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;true_n</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>                        <span class="nv">%</span> <span class="k">if</span> <span class="nv">true</span> <span class="nv">spikes</span> <span class="nv">are</span> <span class="nb">not</span> <span class="nv">available</span></div><div class='line' id='LC27'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">V.use_true_n</span> <span class="nb">=</span> <span class="mi">0</span><span class="c1">;                           % don&#39;t use them for anything</span></div><div class='line' id='LC28'><span class="nv">else</span></div><div class='line' id='LC29'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">V.use_true_n</span> <span class="nb">=</span> <span class="mi">1</span><span class="c1">;</span></div><div class='line' id='LC30'><span class="nv">end</span></div><div class='line' id='LC31'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;smc_iter_max</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>                          <span class="nv">%</span> <span class="nb">max</span> <span class="err">#</span> <span class="nv">of</span> <span class="nv">iterations</span> <span class="nv">before</span> <span class="nv">convergence</span></div><div class='line' id='LC32'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">reply</span> <span class="nb">=</span> <span class="nv">str2double</span><span class="p">(</span><span class="nv">input</span><span class="p">(</span><span class="ss">&#39;\nhow</span> <span class="nv">many</span> <span class="nv">EM</span> <span class="nv">iterations</span> <span class="nv">would</span> <span class="nv">you</span> <span class="nv">like</span> <span class="nv">to</span> <span class="nv">perform</span> <span class="nv">\nto</span> <span class="nv">estimate</span> <span class="nv">parameters</span> <span class="p">(</span><span class="mi">0</span> <span class="nv">means</span> <span class="nv">use</span> <span class="nv">default</span> <span class="nv">parameters</span><span class="p">)</span><span class="err">:</span> <span class="ss">&#39;,</span> <span class="ss">&#39;s</span><span class="o">&#39;</span><span class="p">))</span><span class="c1">;</span></div><div class='line' id='LC33'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">V.smc_iter_max</span> <span class="nb">=</span> <span class="nv">reply</span><span class="c1">;</span></div><div class='line' id='LC34'><span class="nv">end</span></div><div class='line' id='LC35'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;dt</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span></div><div class='line' id='LC36'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">fr</span> <span class="nb">=</span> <span class="nv">input</span><span class="p">(</span><span class="ss">&#39;what</span> <span class="nv">was</span> <span class="k">the</span> <span class="nv">frame</span> <span class="nv">rate</span> <span class="nv">for</span> <span class="nv">this</span> <span class="nv">movie</span> <span class="p">(</span><span class="nv">in</span> <span class="nv">Hz</span><span class="p">)</span><span class="nv">?</span> <span class="o">&#39;</span><span class="p">)</span><span class="c1">;</span></div><div class='line' id='LC37'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">V.dt</span> <span class="nb">=</span> <span class="nv">1/fr</span><span class="c1">;</span></div><div class='line' id='LC38'><span class="nv">end</span></div><div class='line' id='LC39'><br/></div><div class='line' id='LC40'><span class="nv">%</span> <span class="nb">set</span> <span class="nv">which</span> <span class="nv">parameters</span> <span class="nv">to</span> <span class="nv">estimate</span></div><div class='line' id='LC41'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;est_c</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>     <span class="nv">V.est_c</span>     <span class="nb">=</span> <span class="mi">1</span><span class="c1">;    end     % tau_c, A, C_0</span></div><div class='line' id='LC42'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;est_t</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>     <span class="nv">V.est_t</span>     <span class="nb">=</span> <span class="mi">1</span><span class="c1">;    end     % tau_c (useful when data is poor)</span></div><div class='line' id='LC43'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;est_n</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>     <span class="nv">V.est_n</span>     <span class="nb">=</span> <span class="mi">1</span><span class="c1">;    end     % b,k</span></div><div class='line' id='LC44'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;est_h</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>     <span class="nv">V.est_h</span>     <span class="nb">=</span> <span class="mi">0</span><span class="c1">;    end     % w</span></div><div class='line' id='LC45'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;est_F</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>     <span class="nv">V.est_F</span>     <span class="nb">=</span> <span class="mi">1</span><span class="c1">;    end     % alpha, beta</span></div><div class='line' id='LC46'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">V,</span><span class="ss">&#39;smc_plot</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>  <span class="nv">V.smc_plot</span>  <span class="nb">=</span> <span class="mi">1</span><span class="c1">;    end     % plot results with each iteration</span></div><div class='line' id='LC47'><br/></div><div class='line' id='LC48'><span class="nv">%%</span> <span class="nv">initialize</span> <span class="nv">model</span> <span class="nv">Parameters</span></div><div class='line' id='LC49'><br/></div><div class='line' id='LC50'><span class="k">if</span> <span class="nv">nargin</span> <span class="nb">&lt;</span> <span class="mi">3</span><span class="o">,</span>          <span class="nv">P</span>       <span class="nb">=</span> <span class="nv">struct</span><span class="c1">;       end</span></div><div class='line' id='LC51'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;tau_c</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span> <span class="nv">P.tau_c</span> <span class="nb">=</span> <span class="mi">1</span><span class="c1">;            end     % calcium decay time constant (sec)</span></div><div class='line' id='LC52'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;A</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>     <span class="nv">P.A</span>     <span class="nb">=</span> <span class="mi">50</span><span class="c1">;           end     % change ins [Ca++] after a spike (\mu M)</span></div><div class='line' id='LC53'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;C_0</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>   <span class="nv">P.C_0</span>   <span class="nb">=</span> <span class="mi">0</span><span class="c1">;            end     % baseline [Ca++] (\mu M)</span></div><div class='line' id='LC54'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;C_init</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span><span class="nv">P.C_init=</span> <span class="mi">0</span><span class="c1">;            end     % initial [Ca++] (\mu M)</span></div><div class='line' id='LC55'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;sigma_c</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span><span class="nv">P.sigma_c=</span> <span class="mf">0.1</span><span class="c1">;        end     % standard deviation of noise (\mu M)</span></div><div class='line' id='LC56'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;n</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>     <span class="nv">P.n</span>     <span class="nb">=</span> <span class="mi">1</span><span class="c1">;            end     % hill equation exponent</span></div><div class='line' id='LC57'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;k_d</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>   <span class="nv">P.k_d</span>   <span class="nb">=</span> <span class="mi">200</span><span class="c1">;          end     % hill coefficient</span></div><div class='line' id='LC58'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;k</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>                                     <span class="nv">%</span> <span class="nv">linear</span> <span class="nv">filter</span></div><div class='line' id='LC59'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">k</span>   <span class="nb">=</span> <span class="nv">str2double</span><span class="p">(</span><span class="nv">input</span><span class="p">(</span><span class="ss">&#39;approx.</span> <span class="nv">how</span> <span class="nv">many</span> <span class="nv">spikes</span> <span class="nv">underly</span> <span class="nv">this</span> <span class="nv">trace:</span> <span class="ss">&#39;,</span> <span class="ss">&#39;s</span><span class="o">&#39;</span><span class="p">))</span><span class="c1">;</span></div><div class='line' id='LC60'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">P.k</span> <span class="nb">=</span> <span class="nb">log</span><span class="p">(</span><span class="nv">-log</span><span class="p">(</span><span class="nv">1-k/V.T</span><span class="p">)</span><span class="nv">/V.dt</span><span class="p">)</span><span class="c1">;</span></div><div class='line' id='LC61'><span class="nv">end</span></div><div class='line' id='LC62'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;alpha</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span> <span class="nv">P.alpha</span> <span class="nb">=</span> <span class="nv">mean</span><span class="p">(</span><span class="nv">F</span><span class="p">)</span><span class="c1">;      end     % scale of F</span></div><div class='line' id='LC63'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;beta</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>  <span class="nv">P.beta</span>  <span class="nb">=</span> <span class="nb">min</span><span class="p">(</span><span class="nv">F</span><span class="p">)</span><span class="c1">;       end     % offset of F</span></div><div class='line' id='LC64'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;zeta</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>  <span class="nv">P.zeta</span>  <span class="nb">=</span> <span class="nv">P.alpha/5</span><span class="c1">;    end     % constant variance</span></div><div class='line' id='LC65'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;gamma</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span> <span class="nv">P.gamma</span> <span class="nb">=</span> <span class="nv">P.zeta/5</span><span class="c1">;     end     % scaled variance</span></div><div class='line' id='LC66'><span class="k">if</span> <span class="nv">V.Nspikehist==1</span>                                               <span class="nv">%</span> <span class="k">if</span> <span class="nv">there</span> <span class="nv">are</span> <span class="nv">spike</span> <span class="nv">history</span> <span class="nv">terms</span></div><div class='line' id='LC67'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;omega</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>     <span class="nv">P.omega</span>     <span class="nb">=</span> <span class="mi">-1</span><span class="c1">;   end     % weight</span></div><div class='line' id='LC68'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;tau_h</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>     <span class="nv">P.tau_h</span>     <span class="nb">=</span> <span class="mf">0.02</span><span class="c1">; end     % time constant</span></div><div class='line' id='LC69'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;sigma_h</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>   <span class="nv">P.sigma_h</span>   <span class="nb">=</span> <span class="mi">0</span><span class="c1">;    end     % stan dev of noise</span></div><div class='line' id='LC70'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;g</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>         <span class="nv">P.g</span>         <span class="nb">=</span> <span class="nv">V.dt/P.tau_h</span><span class="c1">; end     % for brevity</span></div><div class='line' id='LC71'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;sig2_h</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>    <span class="nv">P.sig2_h</span>    <span class="nb">=</span> <span class="nv">P.sigma_h^2*V.dt</span><span class="c1">; end % for brevity</span></div><div class='line' id='LC72'><span class="nv">end</span></div><div class='line' id='LC73'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;a</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span>     <span class="nv">P.a</span>     <span class="nb">=</span> <span class="nv">V.dt/P.tau_c</span><span class="c1">; end     % for brevity</span></div><div class='line' id='LC74'><span class="k">if</span> <span class="nv">~isfield</span><span class="p">(</span><span class="nv">P,</span><span class="ss">&#39;sig2_c</span><span class="o">&#39;</span><span class="p">)</span><span class="o">,</span><span class="nv">P.sig2_c=</span> <span class="nv">P.sigma_c^2*V.dt</span><span class="c1">; end % for brevity</span></div><div class='line' id='LC75'><br/></div><div class='line' id='LC76'><span class="nv">%%</span> <span class="nv">initialize</span> <span class="nv">other</span> <span class="nv">stuff</span></div><div class='line' id='LC77'><span class="nv">starttime</span>   <span class="nb">=</span> <span class="nv">cputime</span><span class="c1">;</span></div><div class='line' id='LC78'><span class="nv">P.lik</span>       <span class="nb">=</span> <span class="nv">-inf</span><span class="c1">;                                     % we are trying to maximize the likelihood here</span></div><div class='line' id='LC79'><span class="nv">F</span>           <span class="nb">=</span> <span class="nb">max</span><span class="p">(</span><span class="nv">F,eps</span><span class="p">)</span><span class="c1">;                               % in case there are any zeros in the F time series</span></div><div class='line' id='LC80'><br/></div><div class='line' id='LC81'><span class="nv">S</span> <span class="nb">=</span> <span class="nv">smc_oopsi_forward</span><span class="p">(</span><span class="nv">F,V,P</span><span class="p">)</span><span class="c1">;                           % forward step</span></div><div class='line' id='LC82'><span class="nv">M</span> <span class="nb">=</span> <span class="nv">smc_oopsi_backward</span><span class="p">(</span><span class="nv">S,V,P</span><span class="p">)</span><span class="c1">;                          % backward step</span></div><div class='line' id='LC83'><span class="k">if</span> <span class="nv">V.smc_iter_max&gt;1,</span> <span class="nv">P.conv=false</span><span class="c1">; else P.conv=true; end</span></div><div class='line' id='LC84'><br/></div><div class='line' id='LC85'><span class="nv">while</span> <span class="nv">P.conv==false</span><span class="c1">;</span></div><div class='line' id='LC86'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">P</span> <span class="nb">=</span> <span class="nv">smc_oopsi_m_step</span><span class="p">(</span><span class="nv">V,S,M,P,F</span><span class="p">)</span><span class="c1">;                    % m step</span></div><div class='line' id='LC87'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">S</span> <span class="nb">=</span> <span class="nv">smc_oopsi_forward</span><span class="p">(</span><span class="nv">F,V,P</span><span class="p">)</span><span class="c1">;                       % forward step</span></div><div class='line' id='LC88'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="nv">M</span> <span class="nb">=</span> <span class="nv">smc_oopsi_backward</span><span class="p">(</span><span class="nv">S,V,P</span><span class="p">)</span><span class="c1">;                      % backward step</span></div><div class='line' id='LC89'><span class="nv">end</span></div><div class='line' id='LC90'><span class="nv">fprintf</span><span class="p">(</span><span class="ss">&#39;\n</span><span class="o">&#39;</span><span class="p">)</span></div><div class='line' id='LC91'><br/></div><div class='line' id='LC92'><span class="nv">V.smc_iter_tot</span>  <span class="nb">=</span> <span class="nb">length</span><span class="p">(</span><span class="nv">P.lik</span><span class="p">)</span><span class="c1">;</span></div><div class='line' id='LC93'><span class="nv">V.smc_time</span>      <span class="nb">=</span> <span class="nv">cputime-starttime</span><span class="c1">;</span></div><div class='line' id='LC94'><span class="nv">V</span>               <span class="nb">=</span> <span class="nv">orderfields</span><span class="p">(</span><span class="nv">V</span><span class="p">)</span><span class="c1">;</span></div></pre></div></td>
         </tr>
       </table>
  </div>

  </div>
</div>

<a href="#jump-to-line" rel="facebox[.linejump]" data-hotkey="l" class="js-jump-to-line" style="display:none">Jump to Line</a>
<div id="jump-to-line" style="display:none">
  <form accept-charset="UTF-8" class="js-jump-to-line-form">
    <input class="linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" autofocus>
    <button type="submit" class="button">Go</button>
  </form>
</div>

        </div>

      </div><!-- /.repo-container -->
      <div class="modal-backdrop"></div>
    </div><!-- /.container -->
  </div><!-- /.site -->


    </div><!-- /.wrapper -->

      <div class="container">
  <div class="site-footer">
    <ul class="site-footer-links right">
      <li><a href="https://status.github.com/">Status</a></li>
      <li><a href="http://developer.github.com">API</a></li>
      <li><a href="http://training.github.com">Training</a></li>
      <li><a href="http://shop.github.com">Shop</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="/about">About</a></li>

    </ul>

    <a href="/">
      <span class="mega-octicon octicon-mark-github" title="GitHub"></span>
    </a>

    <ul class="site-footer-links">
      <li>&copy; 2014 <span title="0.07101s from github-fe139-cp1-prd.iad.github.net">GitHub</span>, Inc.</li>
        <li><a href="/site/terms">Terms</a></li>
        <li><a href="/site/privacy">Privacy</a></li>
        <li><a href="/security">Security</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
  </div><!-- /.site-footer -->
</div><!-- /.container -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-fullscreen-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="fullscreen-contents js-fullscreen-contents" placeholder="" data-suggester="fullscreen_suggester"></textarea>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped tooltipped-w" aria-label="Exit Zen Mode">
      <span class="mega-octicon octicon-screen-normal"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped tooltipped-w"
      aria-label="Switch themes">
      <span class="octicon octicon-color-mode"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="octicon octicon-alert"></span>
      <a href="#" class="octicon octicon-x close js-ajax-error-dismiss"></a>
      Something went wrong with that request. Please try again.
    </div>


      <script crossorigin="anonymous" src="https://assets-cdn.github.com/assets/frameworks-e87aa86ffae369acf33a96bb6567b2b57183be57.js" type="text/javascript"></script>
      <script async="async" crossorigin="anonymous" src="https://assets-cdn.github.com/assets/github-100ee281915e20c71d6b0ff254fbbb70b3fcaf3a.js" type="text/javascript"></script>
      
      
        <script async src="https://www.google-analytics.com/analytics.js"></script>
  </body>
</html>

