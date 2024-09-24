{ pkgs, config, lib, ... }:

{
  home = {
    packages = [

      (pkgs.symlinkJoin {
        name = "materialgram";
        paths = [ pkgs.materialgram ];
        buildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram "$out/bin/materialgram" --set 'XDG_CURRENT_DESKTOP' 'gnome'
        '';
      })

    ];
    activation =
      let
        constants = # css
          ''
            colorPink: #ff7fc6;
            colorGreen: #0bd500;


            windowBg: colorAlpha0_77;                                            
            windowFg: color7;                                            
            windowBgOver: colorDarker8_30;                              
            windowBgRipple: color1;                                      
            windowFgOver: color15;                                        
            windowSubTextFg: colorDarker7_20;                            
            windowSubTextFgOver: color7;                                 
            windowBoldFg: colorLighter7_20;                              
            windowBoldFgOver: colorLighter7_40;                          
            windowBgActive: colorAlpha2_ff;                                      
            windowFgActive: colorLighter7_40;                            
            windowActiveTextFg: color10;                                  
            windowShadowFg: color0;                                      
            windowShadowFgFallback: color0;                            


            shadowFg: colorAlpha1_66;                                    


            slideFadeOutBg: colorAlpha0_33;                              
            slideFadeOutShadowFg: windowShadowFg;                        


            imageBg: color2;                                             
            imageBgTransparent: color7;                                  


            activeButtonBg: color2;                                      
            activeButtonBgOver: colorLighter2_30;                        
            activeButtonBgRipple: colorLighter2_50;                      
            activeButtonFg: color7;                                      
            activeButtonFgOver: colorLighter7_30;                        
            activeButtonSecondaryFg: colorLighter7_50;                   
            activeButtonSecondaryFgOver: activeButtonSecondaryFg;        
            activeLineFg: color2;                                        
            activeLineFgError: color1;                                   


            lightButtonBg: color0;                                       
            lightButtonBgOver: colorLighter0_40;                         
            lightButtonBgRipple: colorLighter0_60;                       
            lightButtonFg: color2;                                       
            lightButtonFgOver: lightButtonFg;                            


            attentionButtonFg: color1;                                   
            attentionButtonFgOver: colorLighter1_30;                     
            attentionButtonBgOver: colorLighter0_40;                     
            attentionButtonBgRipple: colorLighter0_60;                   


            outlineButtonBg: windowBg;                                   
            outlineButtonBgOver: colorLighter0_40;                       
            outlineButtonOutlineFg: color2;                              
            outlineButtonBgRipple: colorLighter0_60;                     


            menuBg: colorAlpha0_77;                                              
            menuBgOver: colorLighter0_40;                                
            menuBgRipple: colorLighter0_60;                              
            menuIconFg: color7;                                          
            menuIconFgOver: colorLighter7_40;                            
            menuSubmenuArrowFg: color7;                                  
            menuFgDisabled: colorDarker7_40;                             
            menuSeparatorFg: colorDarker7_40;                            


            scrollBarBg: colorAlpha7_55;                                 
            scrollBarBgOver: colorAlpha7_77;                             
            scrollBg: colorAlpha7_11;                                    
            scrollBgOver: colorAlpha7_22;                                


            smallCloseIconFg: colorDarker7_40;                           
            smallCloseIconFgOver: color7;                                


            radialFg: windowFgActive;                                    
            radialBg: colorAlpha0_55;                                    


            placeholderFg: color7;                                       
            placeholderFgActive: colorDarker7_40;                        


            inputBorderFg: color7;                                       


            filterInputBorderFg: colorLighter0_40;                        
            filterInputInactiveBg: colorDarker8_30;                      
            filterInputActiveBg: colorDarker8_20;                        


            checkboxFg: colorDarker7_40;                                 


            sliderBgInactive: colorDarker7_40;                           
            sliderBgActive: windowBgActive;                              


            tooltipBg: color7;                                           
            tooltipFg: color0;                                           
            tooltipBorderFg: color7;                                     


            titleShadow: colorAlpha0_11;                                 
            titleBg: color0;                                             
            titleBgActive: titleBg;                                      
            titleButtonBg: titleBg;                                      
            titleButtonFg: color7;                                       
            titleButtonBgOver: colorLighter0_40;                         
            titleButtonFgOver: colorLighter7_40;                         
            titleButtonBgActive: titleButtonBg;                          
            titleButtonFgActive: titleButtonFg;                          
            titleButtonBgActiveOver: titleButtonBgOver;                  
            titleButtonFgActiveOver: titleButtonFgOver;                  
            titleButtonCloseBg: titleButtonBg;                           
            titleButtonCloseFg: titleButtonFg;                           
            titleButtonCloseBgOver: colorLighter0_40;                    
            titleButtonCloseFgOver: windowFgActive;                      
            titleButtonCloseBgActive: titleButtonCloseBg;                
            titleButtonCloseFgActive: titleButtonCloseFg;                
            titleButtonCloseBgActiveOver: titleButtonCloseBgOver;        
            titleButtonCloseFgActiveOver: titleButtonCloseFgOver;        
            titleFg: color7;                                             
            titleFgActive: colorLighter7_40;                             


            trayCounterBg: color2;                                       
            trayCounterBgMute: color0;                                   
            trayCounterFg: color7;                                       
            trayCounterBgMacInvert: color7;                              
            trayCounterFgMacInvert: color2;                              


            layerBg: colorAlpha0_77;                                     


            cancelIconFg: colorDarker7_40;                               
            cancelIconFgOver: color7;                                    


            boxBg: color0;                                             
            boxTextFg: windowFg;                                         
            boxTextFgGood: color2;                                       
            boxTextFgError: color1;                                      
            boxTitleFg: colorLighter7_40;                                
            boxSearchBg: color0;                                         
            boxTitleAdditionalFg: colorDarker7_40;                       
            boxTitleCloseFg: cancelIconFg;                               
            boxTitleCloseFgOver: cancelIconFgOver;                       


            membersAboutLimitFg: color1;                                 


            contactsBg: colorLighter0_40;                                
            contactsBgOver: color0;                                      
            contactsNameFg: boxTextFg;                                   
            contactsStatusFg: colorDarker7_40;                           
            contactsStatusFgOver: colorDarker7_40;                       
            contactsStatusFgOnline: color10;                              


            photoCropFadeBg: layerBg;                                    
            photoCropPointFg: colorAlpha7_77;                            


            callArrowFg: color2;                                         
            callArrowMissedFg: color1;                                   


            introBg: color0;                                           
            introTitleFg: colorLighter7_40;                              
            introDescriptionFg: color7;                                  
            introErrorFg: color1;                                        
            introCoverTopBg: color2;                                     
            introCoverBottomBg: color2;                                  
            introCoverIconsFg: colorLighter2_40;                         
            introCoverPlaneTrace: colorLighter2_40;                      
            introCoverPlaneInner: colorLighter1_40;                      
            introCoverPlaneOuter: color1;                                
            introCoverPlaneTop: colorLighter7_40;                        


            dialogsMenuIconFg: menuIconFg;                               
            dialogsMenuIconFgOver: menuIconFgOver;                       
            dialogsBg: windowBg;                                         
            dialogsNameFg: colorLighter7_40;                             
            dialogsChatIconFg: dialogsNameFg;                            
            dialogsDateFg: colorDarker7_40;                              
            dialogsTextFg: color7;                                       
            dialogsTextFgService: color7;                                
            dialogsDraftFg: color1;                                      
            dialogsVerifiedIconBg: color10;                                
            dialogsVerifiedIconFg: color0;                                
            dialogsSendingIconFg: color10;                                
            dialogsSentIconFg: color10;                                   
            dialogsUnreadBg: color1;                                     
            dialogsUnreadBgMuted: colorDarker7_40;                       
            dialogsUnreadFg: colorLighter7_40;                           


            dialogsBgOver: colorDarker2_50;                             
            dialogsNameFgOver: windowBoldFgOver;                         
            dialogsChatIconFgOver: dialogsNameFgOver;                    
            dialogsDateFgOver: colorDarker7_40;                          
            dialogsTextFgOver: color7;                                   
            dialogsTextFgServiceOver: color7;                            
            dialogsDraftFgOver: dialogsDraftFg;                          
            dialogsVerifiedIconBgOver: color2;                            
            dialogsVerifiedIconFgOver: color0;                            
            dialogsSendingIconFgOver: dialogsSendingIconFg;              
            dialogsSentIconFgOver: color10;                               
            dialogsUnreadBgOver: colorDarker1_40;                        
            dialogsUnreadBgMutedOver: colorDarker7_40;                   
            dialogsUnreadFgOver: dialogsUnreadFg;                        


            dialogsBgActive: color2;                                     
            dialogsNameFgActive: windowBoldFgOver;                       
            dialogsChatIconFgActive: dialogsNameFgActive;                
            dialogsDateFgActive: colorLighter7_40;                       
            dialogsTextFgActive: colorLighter7_40;                       
            dialogsTextFgServiceActive: colorLighter7_40;                
            dialogsDraftFgActive: colorLighter7_40;                      
            dialogsVerifiedIconBgActive: dialogsTextFgActive;             
            dialogsVerifiedIconFgActive: dialogsBgActive;                 
            dialogsSendingIconFgActive: colorLighter7_40;                
            dialogsSentIconFgActive: dialogsTextFgActive;                
            dialogsUnreadBgActive: dialogsTextFgActive;                  
            dialogsUnreadBgMutedActive: colorLighter7_40;                
            dialogsUnreadFgActive: colorLighter7_40;                     


            dialogsRippleBg: colorLighter0_60;                           
            dialogsRippleBgActive: colorLighter2_40;                     


            dialogsForwardBg: dialogsBgActive;                           
            dialogsForwardFg: dialogsNameFgActive;                       


            searchedBarBg: colorLighter0_40;                             
            searchedBarFg: color7;                                       


            topBarBg: color0;                                            


            emojiPanBg: colorAlpha0_ee;                                        
            emojiPanCategories: color0;                                  
            emojiPanHeaderFg: color7;                                    
            emojiPanHeaderBg: color0;                                    
            emojiIconFg: color7;                                         
            emojiIconFgActive: color2;                                   


            stickerPanDeleteBg: colorAlpha0_cc;                          
            stickerPanDeleteFg: windowFgActive;                          
            stickerPreviewBg: colorAlpha0_bb;                            


            historyTextInFg: windowFg;                                   
            historyTextInFgSelected: colorLighter7_40;                   
            historyTextOutFg: color7;                                    
            historyTextOutFgSelected: colorLighter7_40;                  
            historyLinkInFg: color10;                                     
            historyLinkInFgSelected: colorLighter7_40;                   
            historyLinkOutFg: color10;                                    
            historyLinkOutFgSelected: colorLighter7_40;                  
            historyFileNameInFg: historyTextInFg;                        
            historyFileNameInFgSelected: colorLighter7_40;               
            historyFileNameOutFg: historyTextOutFg;                      
            historyFileNameOutFgSelected: colorLighter7_40;              
            historyOutIconFg: colorLighter10_70;                                    
            historyOutIconFgSelected: colorLighter7_40;                  
            historyIconFgInverted: color2;                               
            historySendingOutIconFg: color2;                             
            historySendingInIconFg: color2;                              
            historySendingInvertedIconFg: colorAlpha2_cc;                
            historyCallArrowInFg: color1;                                
            historyCallArrowInFgSelected: colorLighter7_40;              
            historyCallArrowMissedInFg: callArrowMissedFg;               
            historyCallArrowMissedInFgSelected: colorLighter7_40;        
            historyCallArrowOutFg: colorLighter7_40;                     
            historyCallArrowOutFgSelected: colorLighter7_40;             
            historyUnreadBarBg: color0;                                  
            historyUnreadBarBorder: shadowFg;                            
            historyUnreadBarFg: color1;                                  
            historyForwardChooseBg: colorAlpha0_44;                      
            historyForwardChooseFg: windowFgActive;                      
            historyPeer1NameFg: color1;                                  
            historyPeer1NameFgSelected: colorLighter7_40;                
            historyPeer1UserpicBg: color1;                               
            historyPeer2NameFg: color2;                                  
            historyPeer2NameFgSelected: colorLighter7_40;                
            historyPeer2UserpicBg: color2;                               
            historyPeer3NameFg: color3;                                  
            historyPeer3NameFgSelected: colorLighter7_40;                
            historyPeer3UserpicBg: color3;                               
            historyPeer4NameFg: color4;                                  
            historyPeer4NameFgSelected: colorLighter7_40;                
            historyPeer4UserpicBg: color4;                               
            historyPeer5NameFg: color5;                                  
            historyPeer5NameFgSelected: colorLighter7_40;                
            historyPeer5UserpicBg: color5;                               
            historyPeer6NameFg: color6;                                  
            historyPeer6NameFgSelected: colorLighter7_40;                
            historyPeer6UserpicBg: color6;                               
            historyPeer7NameFg: color7;                                  
            historyPeer7NameFgSelected: colorLighter7_40;                
            historyPeer7UserpicBg: color7;                               
            historyPeer8NameFg: color8;                                  
            historyPeer8NameFgSelected: colorLighter7_40;                
            historyPeer8UserpicBg: color8;                               
            historyPeerUserpicFg: windowFgActive;                        
            historyScrollBarBg: colorAlpha7_77;                          
            historyScrollBarBgOver: colorAlpha7_bb;                      
            historyScrollBg: colorAlpha7_44;                             
            historyScrollBgOver: colorAlpha7_66;                         


            msgInBg: colorDarker7_70;                                             
            msgInBgSelected: color2;                                     
            msgOutBg: colorDarker8_60;                                            
            msgOutBgSelected: color2;                                    
            msgSelectOverlay: colorAlpha2_44;                            
            msgStickerOverlay: colorAlpha2_77;                           
            msgInServiceFg: windowActiveTextFg;                          
            msgInServiceFgSelected: colorLighter7_40;                    
            msgOutServiceFg: color10;                                     
            msgOutServiceFgSelected: colorLighter7_40;                   
            msgInShadow: colorAlpha0_00;                                 
            msgInShadowSelected: colorAlpha2_00;                         
            msgOutShadow: colorAlpha0_00;                                
            msgOutShadowSelected: colorAlpha2_00;                        
            msgInDateFg: colorDarker7_40;                                
            msgInDateFgSelected: colorLighter7_40;                       
            msgOutDateFg: colorDarker7_40;                               
            msgOutDateFgSelected: colorLighter7_40;                      
            msgServiceFg: windowFgActive;                                
            msgServiceBg: color0;                                        
            msgServiceBgSelected: color10;                                
            msgInReplyBarColor: color10;                                  
            msgInReplyBarSelColor: colorLighter7_40;                     
            msgOutReplyBarColor: color10;                                 
            msgOutReplyBarSelColor: colorLighter7_40;                     
            msgImgReplyBarColor: msgServiceFg;                           
            msgInMonoFg: colorLighter3_20;                               
            msgInMonoFgSelected: colorLighter7_40;                       
            msgOutMonoFg: colorLighter3_20;                              
            msgOutMonoFgSelected: colorLighter7_40;                      
            msgDateImgFg: msgServiceFg;                                  
            msgDateImgBg: colorAlpha0_55;                                
            msgDateImgBgOver: colorAlpha0_77;                            
            msgDateImgBgSelected: colorAlpha2_88;                        
            msgFileThumbLinkInFg: lightButtonFg;                         
            msgFileThumbLinkInFgSelected: lightButtonFgOver;             
            msgFileThumbLinkOutFg: color10;                               
            msgFileThumbLinkOutFgSelected: colorLighter7_40;             
            msgFileInBg: color2;                                         
            msgFileInBgOver: colorLighter2_30;                           
            msgFileInBgSelected: colorLighter2_50;                       
            msgFileOutBg: color2;                                        
            msgFileOutBgOver: colorLighter2_30;                          
            msgFileOutBgSelected: colorLighter2_50;                      
            msgFile1Bg: color1;                                          
            msgFile1BgDark: colorDarker1_30;                             
            msgFile1BgOver: colorLighter1_40;                            
            msgFile1BgSelected: colorLighter7_40;                        
            msgFile2Bg: color2;                                          
            msgFile2BgDark: colorDarker2_30;                             
            msgFile2BgOver: colorLighter2_40;                            
            msgFile2BgSelected: colorLighter7_40;                        
            msgFile3Bg: color3;                                          
            msgFile3BgDark: colorDarker7_30;                             
            msgFile3BgOver: colorLighter7_40;                            
            msgFile3BgSelected: colorLighter7_40;                        
            msgFile4Bg: color3;                                          


            msgFile4BgSelected: colorLighter7_40;                        
            msgWaveformInActive: windowBgActive;                         
            msgWaveformInActiveSelected: colorLighter7_40;               
            msgWaveformInInactive: colorDarker7_30;                      
            msgWaveformInInactiveSelected: colorLighter2_40;             
            msgWaveformOutActive: color2;                                
            msgWaveformOutActiveSelected: colorLighter7_40;              
            msgWaveformOutInactive: colorDarker7_30;                     
            msgWaveformOutInactiveSelected: colorLighter2_40;            
            msgBotKbOverBgAdd: colorAlpha7_11;                           
            msgBotKbIconFg: msgServiceFg;                                
            msgBotKbRippleBg: colorAlpha1_11;                            


            historyFileInIconFg: color0;                                 
            historyFileInIconFgSelected: color10;                         
            historyFileInRadialFg: color0;                               
            historyFileInRadialFgSelected: historyFileInIconFgSelected;  
            historyFileOutIconFg: color0;                                
            historyFileOutIconFgSelected: color10;                        
            historyFileOutRadialFg: historyFileOutIconFg;                
            historyFileOutRadialFgSelected: color10;                      
            historyFileThumbIconFg: colorLighter7_40;                    
            historyFileThumbIconFgSelected: colorLighter7_40;            
            historyFileThumbRadialFg: historyFileThumbIconFg;            
            historyFileThumbRadialFgSelected: colorLighter7_40;          
            historyVideoMessageProgressFg: historyFileThumbIconFg;       


            youtubePlayIconBg: #83131c88;                                 
            youtubePlayIconFg: windowFgActive;                           


            videoPlayIconBg: colorAlpha0_77;                             
            videoPlayIconFg: colorLighter7_40;                           


            toastBg: colorAlpha0_bb;                                     
            toastFg: windowFgActive;                                     


            reportSpamBg: color0;                                        
            reportSpamFg: windowFg;                                      


            historyToDownBg: color0;                                     
            historyToDownBgOver: colorLighter0_40;                       
            historyToDownBgRipple: colorLighter0_60;                     
            historyToDownFg: color7;                                     
            historyToDownFgOver: menuIconFgOver;                         
            historyToDownShadow: colorAlpha0_44;                         
            historyComposeAreaBg: color0;                                
            historyComposeAreaFg: historyTextInFg;                       
            historyComposeAreaFgService: msgInDateFg;                    
            historyComposeIconFg: menuIconFg;                            
            historyComposeIconFgOver: menuIconFgOver;                    
            historySendIconFg: windowBgActive;                           
            historySendIconFgOver: windowBgActive;                       
            historyPinnedBg: historyComposeAreaBg;                       
            historyReplyBg: historyComposeAreaBg;                        
            historyReplyIconFg: windowBgActive;                          
            historyReplyCancelFg: cancelIconFg;                          
            historyReplyCancelFgOver: cancelIconFgOver;                  
            historyComposeButtonBg: historyComposeAreaBg;                
            historyComposeButtonBgOver: colorLighter0_40;                
            historyComposeButtonBgRipple: colorLighter0_60;              


            overviewCheckBg: colorAlpha0_44;                             
            overviewCheckFg: colorLighter7_40;                           
            overviewCheckFgActive: colorLighter7_40;                     
            overviewPhotoSelectOverlay: colorAlpha1_33;                  


            profileStatusFgOver: color1;                                  
            profileVerifiedCheckBg: windowBgActive;                        
            profileVerifiedCheckFg: windowFgActive;                        
            profileAdminStartFg: windowBgActive;                          


            notificationsBoxMonitorFg: windowFg;                          
            notificationsBoxScreenBg: dialogsBgActive;                    
            notificationSampleUserpicFg: windowBgActive;                  
            notificationSampleCloseFg: color7;                            
            notificationSampleTextFg: color7;                             
            notificationSampleNameFg: colorLighter0_40;                   


            changePhoneSimcardFrom: notificationSampleTextFg;             
            changePhoneSimcardTo: notificationSampleNameFg;               


            mainMenuBg: color0;                                        
            mainMenuCoverBg: color2;                                     
            mainMenuCoverFg: windowFgActive;                             
            mainMenuCloudFg: colorLighter7_40;                           
            mainMenuCloudBg: color4;                                     


            mediaInFg: msgInDateFg;                                      
            mediaInFgSelected: msgInDateFgSelected;                      
            mediaOutFg: msgOutDateFg;                                    
            mediaOutFgSelected: msgOutDateFgSelected;                    
            mediaPlayerBg: windowBg;                                     
            mediaPlayerActiveFg: windowBgActive;                         
            mediaPlayerInactiveFg: sliderBgInactive;                     
            mediaPlayerDisabledFg: color1;                               


            mediaviewFileBg: windowBg;                                   
            mediaviewFileNameFg: windowFg;                               
            mediaviewFileSizeFg: windowSubTextFg;                        
            mediaviewFileRedCornerFg: color1;                            
            mediaviewFileYellowCornerFg: color2;                         
            mediaviewFileGreenCornerFg: color3;                          
            mediaviewFileBlueCornerFg: color4;                           
            mediaviewFileExtFg: activeButtonFg;                          
            mediaviewMenuBg: color0;                                     
            mediaviewMenuBgOver: colorLighter0_40;                       
            mediaviewMenuBgRipple: colorLighter0_60;                     
            mediaviewMenuFg: windowFgActive;                             
            mediaviewBg: colorDarker0_30;                                
            mediaviewVideoBg: imageBg;                                   
            mediaviewControlBg: colorDarker0_50;                         
            mediaviewControlFg: windowFgActive;                          
            mediaviewCaptionBg: colorDarker0_50;                         
            mediaviewCaptionFg: mediaviewControlFg;                      
            mediaviewTextLinkFg: color7;                                 
            mediaviewSaveMsgBg: toastBg;                                 
            mediaviewSaveMsgFg: toastFg;                                 
            mediaviewPlaybackActive: color7;                             
            mediaviewPlaybackInactive: colorDarker7_50;                  
            mediaviewPlaybackActiveOver: colorLighter7_40;               
            mediaviewPlaybackInactiveOver: colorDarker7_30;              
            mediaviewPlaybackProgressFg: colorLighter7_40;               
            mediaviewPlaybackIconFg: mediaviewPlaybackActive;            
            mediaviewPlaybackIconFgOver: mediaviewPlaybackActiveOver;    
            mediaviewTransparentBg: colorLighter7_40;                    
            mediaviewTransparentFg: color7;                              
            notificationBg: windowBg;                                     


            callBg: colorAlpha0_ff;                                      
            callNameFg: colorLighter7_40;                                
            callFingerprintBg: colorAlpha0_66;                           
            callStatusFg: color7;                                        
            callIconFg: colorLighter7_40;                                
            callAnswerBg: color2;                                        
            callAnswerRipple: colorDarker2_30;                           
            callAnswerBgOuter: colorLighter2_30;                         
            callHangupBg: color1;                                        
            callHangupRipple: colorDarker1_30;                           
            callCancelBg: colorLighter7_40;                              
            callCancelFg: colorDarker7_40;                               
            callCancelRipple: colorLighter7_40;                          
            callMuteRipple: #ffffff12;                                      
            callBarBg: dialogsBgActive;                                  
            callBarMuteRipple: dialogsRippleBgActive;                    
            callBarBgMuted: colorLighter0_40;                            
            callBarUnmuteRipple: colorLighter0_40;                       
            callBarFg: dialogsNameFgActive;                              


            importantTooltipBg: toastBg;                                 
            importantTooltipFg: toastFg;                                 
            importantTooltipFgLink: color2;                              


            botKbBg: color0;                                             
            botKbDownBg: colorLighter0_40;                               


            overviewCheckBorder: color2;                                 


            sideBarBg: color0;
            sideBarBgActive: color2;
            sideBarBgRipple: color1;
            sideBarTextFg: color1;
            sideBarTextFgActive: color7;
            sideBarIconFg: color7;
            sideBarIconFgActive: colorLighter7_40;
            sideBarBadgeBg: color1;
            sideBarBadgeBgMuted: colorDarker7_40;
            sideBarBadgeFg: colorLighter7_40;


            profileOtherAdminStarFg: color7;                             
          '';
        walogram = pkgs.writeShellApplication {
          name = "walogram";
          runtimeInputs = with pkgs; [ file zip imagemagick ];
          bashOptions = [ "pipefail" ];
          text =
            let
              inherit (config.lib.stylix) colors;
              # bash
            in
            ''

          tempdir="$(mktemp -d)"
          cachedir="${config.xdg.cacheHome}/stylix-telegram-theme"
          themename="stylix.tdesktop-theme"
          mkdir -p "$cachedir"

          walmode="background"
          blur="true"

          gencolors() {
            colors="0 1 2 3 4 5 7 8 9 10 11 12 13 14 15"
            divisions="10 20 30 40 50 60 70 80 90"
            alphas="00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee"

            for i in $colors; do
              color="color$i"
              c_rgb_12d=$((0x"''${!color:1:2}"))
              c_rgb_34d=$((0x"''${!color:3:2}"))
              c_rgb_56d=$((0x"''${!color:5:2}"))

              for division in $divisions; do
                # lighter variants
                c_r=$((c_rgb_12d + (c_rgb_12d * (division / 10) / 10)))
                c_g=$((c_rgb_34d + (c_rgb_34d * (division / 10) / 10)))
                c_b=$((c_rgb_56d + (c_rgb_56d * (division / 10) / 10)))
                [ "$c_r" -ge 255 ] && c_r=255
                [ "$c_g" -ge 255 ] && c_g=255
                [ "$c_b" -ge 255 ] && c_b=255
                c_hex_r="$(printf "%x" "$c_r")"
                c_hex_g="$(printf "%x" "$c_g")"
                c_hex_b="$(printf "%x" "$c_b")"
                [ "''${#c_hex_r}" -eq 1 ] && c_hex_r="0''${c_hex_r}"
                [ "''${#c_hex_g}" -eq 1 ] && c_hex_g="0''${c_hex_g}"
                [ "''${#c_hex_b}" -eq 1 ] && c_hex_b="0''${c_hex_b}"
                c_hex="#''${c_hex_r}''${c_hex_g}''${c_hex_b}"
                eval "color''${i}_lighter_''${division}=''${c_hex}"

                # darker variants
                c_r=$((c_rgb_12d - (c_rgb_12d * (division / 10) / 10)))
                c_g=$((c_rgb_34d - (c_rgb_34d * (division / 10) / 10)))
                c_b=$((c_rgb_56d - (c_rgb_56d * (division / 10) / 10)))
                c_hex_r="$(printf "%x" "$c_r")"
                c_hex_g="$(printf "%x" "$c_g")"
                c_hex_b="$(printf "%x" "$c_b")"
                [ "''${#c_hex_r}" -eq 1 ] && c_hex_r="0''${c_hex_r}"
                [ "''${#c_hex_g}" -eq 1 ] && c_hex_g="0''${c_hex_g}"
                [ "''${#c_hex_b}" -eq 1 ] && c_hex_b="0''${c_hex_b}"
                c_hex="#''${c_hex_r}''${c_hex_g}''${c_hex_b}"
                eval "color''${i}_darker_''${division}=''${c_hex}"
              done
            done

            for i in $colors; do
              echo "// color$i: original"
              echo "color$i: $(eval "echo \"\$color''${i}\"");"

              echo "// color$i: lighter and darker variants"
              for division in $divisions; do
                echo "colorLighter''${i}_''${division}: $(eval "echo \"\$color''${i}_lighter_''${division}\"");"
                echo "colorDarker''${i}_''${division}: $(eval "echo \"\$color''${i}_darker_''${division}\"");"
              done

              echo "// color$i: alpha variants"
              for alpha in $alphas; do
                echo "colorAlpha''${i}_''${alpha}: $(eval "echo \"\''${color''${i}}''${alpha}\"");"
              done
              printf "\\n" 
            done
          }

          gentheme() {
            walname="background.jpg"

            # shellcheck disable=SC2188
            echo "${constants}" > "$tempdir/constants"
            trap 'rm -rf "$tempdir"; exit 0' INT TERM EXIT
            gencolors | cat - "$tempdir/constants" >"$tempdir/colors.tdesktop-theme"
            if command -v zip >/dev/null 2>&1; then
              if [ "$walmode" = "solid" ]; then
                # $background is set by wal in colors.sh template
                magick convert -size 256x256 "xc:''${bgcolor:-''${background:-$color0}}" "$tempdir/$walname"
              else
                case "$(file -b --mime-type "${config.stylix.image}")" in
                image/*) convert ''${blur:+-blur 0x16} -resize 1920x1080 "${config.stylix.image}" "$tempdir/$walname" ;;
                *) echo "not an image: ${config.stylix.image}" ;;
                esac
              fi
              # syncing files (with '-FS') in an existing archive is faster than creating new
              zip -jq -FS "$cachedir/$themename" "$tempdir"/*
            else
              msg "'zip' not found. theme generated without background image"
              cp -f "$tempdir/colors.tdesktop-theme" "$cachedir/$themename"
            fi
          }

          # shellcheck disable=SC2034 
          color0="#${colors.base00}"
          # shellcheck disable=SC2034 
          color1="#${colors.base01}"
          # shellcheck disable=SC2034 
          color2="#${colors.base02}"
          # shellcheck disable=SC2034 
          color3="#${colors.base03}"
          # shellcheck disable=SC2034 
          color4="#${colors.base04}"
          # shellcheck disable=SC2034 
          color5="#${colors.base05}"
          # shellcheck disable=SC2034 
          color6="#${colors.base06}"
          # shellcheck disable=SC2034 
          color7="#${colors.base07}"
          # shellcheck disable=SC2034 
          color8="#${colors.base08}"
          # shellcheck disable=SC2034 
          color9="#${colors.base09}"
          # shellcheck disable=SC2034 
          color10="#${colors.base0A}"
          # shellcheck disable=SC2034 
          color11="#${colors.base0B}"
          # shellcheck disable=SC2034 
          color12="#${colors.base0C}"
          # shellcheck disable=SC2034 
          color13="#${colors.base0D}"
          # shellcheck disable=SC2034 
          color14="#${colors.base0E}"
          # shellcheck disable=SC2034 
          color15="#${colors.base0F}"

          # ensure all 16 colors are set
          for i in 0 1 2 3 4 5 6 7; do
            normal="color$i"
            bright="color$((i + 8))"
            [ -z "$(eval "echo \"\$$normal\"")" ] && error "$normal value is missing"
            [ -z "$(eval "echo \"\$$bright\"")" ] && {
              msg "$normal value used for $bright, because it is unset"
              eval "$bright=\$$normal"
            }
          done

          gentheme
        '';
        };
      in
      {
        tg-theme = lib.hm.dag.entryAfter [ "" ] ''
          run ${lib.getExe walogram}
        '';
      };
  };
}
