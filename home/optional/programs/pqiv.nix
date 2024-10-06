{ config, ... }: {
  programs.pqiv = {
    enable = true;
    settings = {
      options = {
        box-colors =
          "#${config.lib.stylix.colors.base00}:#${config.lib.stylix.colors.base0F}";
        disable-backends = "archive,archive_cbx,libav,poppler,spectre,wand";
        hide-info-box = 1;
        max-depth = 1;
        transparent-background = 1;
        window-position = "off";
      };
    };
    extraConfig = ''
      [keybindings]
        <Control><period>       { animation_continue()                }
        <Alt><KP_Subtract>      { animation_set_speed_relative(0.9)   }
        <Alt><minus>            { animation_set_speed_relative(0.9)   }
        <Alt><KP_Add>           { animation_set_speed_relative(1.1)   }
        <Alt><plus>             { animation_set_speed_relative(1.1)   }
        <period>                { animation_step(1)                   }
        <Control>t              { clear_marks()                       }
        h                       { flip_horizontally()                 }
        v                       { flip_vertically()                   }
        <Control>p              { goto_earlier_file()                 }
        p                       { goto_file_relative(-1)              }
        <Control>d              { goto_file_relative(-3)              }
        n                       { goto_file_relative(1)               }
        <Control>u              { goto_file_relative(3)               }
        P                       { goto_logical_directory_relative(-1) }
        N                       { goto_logical_directory_relative(1)  }
        <Control>a              { hardlink_current_image()            }
        /                       { jump_dialog()                       }
        <space>                 { montage_mode_enter()                }
        1                       { numeric_command(1)                  }
        2                       { numeric_command(2)                  }
        3                       { numeric_command(3)                  }
        4                       { numeric_command(4)                  }
        5                       { numeric_command(5)                  }
        6                       { numeric_command(6)                  }
        7                       { numeric_command(7)                  }
        8                       { numeric_command(8)                  }
        9                       { numeric_command(9)                  }
        <Escape>                { quit()                              }
        q                       { quit()                              }
        <Alt>r                  { reload()                            }
        0                       { reset_scale_level()                 }
        R                       { rotate_left()                       }
        r                       { rotate_right()                      }
        <KP_Subtract>           { set_scale_level_relative(0.9)       }
        <minus>                 { set_scale_level_relative(0.9)       }
        <KP_Add>                { set_scale_level_relative(1.1)       }
        <plus>                  { set_scale_level_relative(1.1)       }
        <Control><KP_Subtract>  { set_slideshow_interval_relative(-1) }
        <Control><minus>        { set_slideshow_interval_relative(-1) }
        <Control><KP_Add>       { set_slideshow_interval_relative(1)  }
        <Control><plus>         { set_slideshow_interval_relative(1)  }
        l                       { shift_x(-10)                        }
        h                       { shift_x(10)                         }
        j                       { shift_y(-10)                        }
        k                       { shift_y(10)                         }
        b                       { toggle_background_pattern(0)        }
        f                       { toggle_fullscreen(0)                }
        i                       { toggle_info_box()                   }
        t                       { toggle_mark()                       }
        <Control>n              { toggle_negate_mode(0)               }
        z                       { toggle_scale_mode(0)                }
        <Control>z              { toggle_scale_mode(4)                }
        <Alt>z                  { toggle_scale_mode(5)                }
        <Control>r              { toggle_shuffle_mode(0)              }
        s                       { toggle_slideshow()                  }

        @MONTAGE {
        <Control>t  { clear_marks() }
                 G  { goto_file_byindex(-1) }
                gg  { goto_file_byindex(0) }
                 f  { montage_mode_follow(asdfghjkl) }
          <Escape>  { montage_mode_return_cancel() }
          <Return>  { montage_mode_return_proceed() }
                 h  { montage_mode_shift_x(-1) }
                 l  { montage_mode_shift_x(1) }
                 k  { montage_mode_shift_y(-1) }
                 j  { montage_mode_shift_y(1) }
        <Control>u  { montage_mode_shift_y_pg(-1) }
        <Control>d  { montage_mode_shift_y_pg(1) }
        <Mouse-Scroll-2>  { montage_mode_shift_y_rows(-1) }
        <Mouse-Scroll-1>  { montage_mode_shift_y_rows(1) }
                 q  { quit() }
                 t  { toggle_mark() }
        }    '';
  };

  xdg.mimeApps.defaultApplications = {
    "image/jpeg" = "pqiv.desktop";
    "image/gif" = "pqiv.desktop";
    "image/webp" = "pqiv.desktop";
    "image/png" = "pqiv.desktop";
    "image/svg+xml" = "pqiv.desktop";
  };
}
