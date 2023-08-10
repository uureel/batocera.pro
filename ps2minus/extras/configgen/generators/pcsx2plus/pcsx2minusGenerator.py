#!/usr/bin/env python

import generators
from configgen.generators.Generator import Generator
import Command as Command
import os
import shutil
import stat
from os import path
import batoceraFiles as batoceraFiles
from xml.dom import minidom
import codecs
import controllersConfig as controllersConfig
import configparser
from shutil import copyfile
from utils.logger import get_logger

eslog = get_logger(__name__)

class PCSX2MINUSGenerator(Generator):

    def generate(self, system, rom, playersControllers, gameResolution):
        #handles chmod so you just need to download pcsx2minus.AppImage
        if os.path.exists("/userdata/system/pro/ps2minus/pcsx2/pcsx2-AVX2.AppImage"):
            st = os.stat("/userdata/system/pro/ps2minus/pcsx2/pcsx2-AVX2.AppImage")
            os.chmod("/userdata/system/pro/ps2minus/pcsx2/pcsx2-AVX2.AppImage", st.st_mode | stat.S_IEXEC)

        if os.path.exists("/userdata/system/pro/ps2minus/pcsx2/pcsx2-SSE4.AppImage"):
            st = os.stat("/userdata/system/pro/ps2minus/pcsx2/pcsx2-SSE4.AppImage")
            os.chmod("/userdata/system/pro/ps2minus/pcsx2/pcsx2-SSE4.AppImage", st.st_mode | stat.S_IEXEC)

        if os.path.exists("/userdata/system/pro/ps2minus/launcher.sh"):
            st = os.stat("/userdata/system/pro/ps2minus/launcher.sh")
            os.chmod("/userdata/system/pro/ps2minus/launcher.sh", st.st_mode | stat.S_IEXEC)
        
        pcsx2minusConfig = '/userdata/system/pro/ps2minus/pcsx2/.config1'
        beforepcsx2minusConfig = '/userdata/system/pro/ps2minus/pcsx2/.config0'
        
        PCSX2MINUSGenerator.writePCSX2MINUSConfig(pcsx2minusConfig,beforepcsx2minusConfig, system, playersControllers)
        commandArray = ["/userdata/system/pro/ps2minus/launcher.sh", rom ]

        return Command.Command(
            array=commandArray,
            env={"QT_QPA_PLATFORM":"xcb","SDL_GAMECONTROLLERCONFIG": controllersConfig.generateSdlGameControllerConfig(playersControllers) }
            )


    # @staticmethod
    def writePCSX2MINUSConfig(pcsx2minusConfigFile, beforepcsx2minusConfigFile, system, playersControllers):
        # pads
        pcsx2minusButtons = {
            "button_a":      "a",
            "button_b":      "b",
            "button_x":      "x",
            "button_y":      "y",
            "button_dup":     "up",
            "button_ddown":   "down",
            "button_dleft":   "left",
            "button_dright":  "right",
            "button_l":      "pageup",
            "button_r":      "pagedown",
            "button_plus":  "start",
            "button_minus": "select",
            "button_sl":     "pageup",
            "button_sr":     "pagedown",
            "button_zl":     "l2",
            "button_zr":     "r2",
            "button_lstick":     "l3",
            "button_rstick":     "r3",
            "button_home":   "hotkey"
        }

        pcsx2minusAxis = {
            "lstick":    "joystick1",
            "rstick":    "joystick2"
        }


        pcsx2minusDSButtons = {
            "button_a":      1,
            "button_b":      0,
            "button_x":      3,
            "button_y":      2,
            "button_dup":     11,
            "button_ddown":   12,
            "button_dleft":   13,
            "button_dright":  14,
            "button_l":      9,
            "button_r":      10,
            "button_plus":  6,
            "button_minus": 4,
            "button_sl":     9,
            "button_sr":     10,
            "button_lstick":     7,
            "button_rstick":     8,
            "button_home":   5
        }

        pcsx2minusDSAxis = {
            "lstick":    0,
            "rstick":    2,
            "button_zl":     4,
            "button_zr":     5
        }

        pcsx2minusSCButtons = {
            "button_a":      6,
            "button_b":     5,
            "button_x":      8,
            "button_y":      7,
            "button_dup":     20,
            "button_ddown":   21,
            "button_dleft":   22,
            "button_dright":  23,
            "button_l":      9,
            "button_r":      10,
            "button_plus":  14,
            "button_minus": 13,
            #"button_zl":     18,
            #"button_zr":     10,
            "button_lstick":     16,
            "button_rstick":     17,
            "button_home":   13
        }

        pcsx2minusSCAxis = {
            "lstick":    1,
            "rstick":    4,
            "button_zl":     2,
            "button_zr":     5
        }

        pcsx2minusSCButtons2 = {
            "button_a":      4,
            "button_b":     5,
            "button_x":      6,
            "button_y":      7,
            "button_dup":     19,
            "button_ddown":   20,
            "button_dleft":   21,
            "button_dright":  22,
            "button_l":      8,
            "button_r":      10,
            "button_plus":  13,
            "button_minus": 12,
            #"button_zl":     18,
            #"button_zr":     10,
            "button_lstick":     15,
            "button_rstick":     16,
            "button_home":   23
        }

        pcsx2minusSCAxis2 = {
            "lstick":    1,
            "rstick":    4,
            "button_zl":     2,
            "button_zr":     5
        }


        # ini file
        pcsx2minusConfig = configparser.RawConfigParser()
        pcsx2minusConfig.optionxform=str
        if os.path.exists(pcsx2minusConfigFile):
            pcsx2minusConfig.read(pcsx2minusConfigFile)

        
    # UI section
        if not pcsx2minusConfig.has_section("UI"):
            pcsx2minusConfig.add_section("UI")
        
        pcsx2minusConfig.set("UI", "fullscreen", "true")
        pcsx2minusConfig.set("UI", "fullscreen\\default", "false")
        pcsx2minusConfig.set("UI", "confirmClose", "false")
        pcsx2minusConfig.set("UI", "confirmClose\\default", "false")
        pcsx2minusConfig.set("UI", "firstStart", "false")
        pcsx2minusConfig.set("UI", "firstStart\\default", "false")
        pcsx2minusConfig.set("UI", "displayTitleBars", "false")
        pcsx2minusConfig.set("UI", "displayTitleBars\\default", "false")

        if system.isOptSet('pcsx2minus_enable_discord_presence'):
            pcsx2minusConfig.set("UI", "enable_discord_presence", system.config["pcsx2minus_enable_discord_presence"])
        else:
            pcsx2minusConfig.set("UI", "enable_discord_presence", "false")

        pcsx2minusConfig.set("UI", "enable_discord_presence\\default", "false")



        pcsx2minusConfig.set("UI", "calloutFlags", "1")
        pcsx2minusConfig.set("UI", "calloutFlags\\default", "false")

        # Single Window Mode
        if system.isOptSet('single_window'):
            pcsx2minusConfig.set("UI", "singleWindowMode", system.config["single_window"])
            pcsx2minusConfig.set("UI", "singleWindowMode\\default", "false")
        else:
            pcsx2minusConfig.set("UI", "singleWindowMode", "true")
            pcsx2minusConfig.set("UI", "singleWindowMode\\default", "true")

        pcsx2minusConfig.set("UI", "hideInactiveMouse", "true")
        pcsx2minusConfig.set("UI", "hideInactiveMouse\\default", "true")

        # Roms path (need for load update/dlc)
        pcsx2minusConfig.set("UI", "Paths\\gamedirs\\1\\deep_scan", "true")
        pcsx2minusConfig.set("UI", "Paths\\gamedirs\\1\\deep_scan\\default", "false")
        pcsx2minusConfig.set("UI", "Paths\\gamedirs\\1\\expanded", "true")
        pcsx2minusConfig.set("UI", "Paths\\gamedirs\\1\\expanded\\default", "true")
        pcsx2minusConfig.set("UI", "Paths\\gamedirs\\1\\path", "/userdata/roms/switch")
        pcsx2minusConfig.set("UI", "Paths\\gamedirs\\size", "1")

        pcsx2minusConfig.set("UI", "Screenshots\\enable_screenshot_save_as", "true")
        pcsx2minusConfig.set("UI", "Screenshots\\enable_screenshot_save_as\\default", "true")
        pcsx2minusConfig.set("UI", "Screenshots\\screenshot_path", "/userdata/screenshots")
        pcsx2minusConfig.set("UI", "Screenshots\\screenshot_path\\default", "false")

    # Data Storage section
        if not pcsx2minusConfig.has_section("Data%20Storage"):
            pcsx2minusConfig.add_section("Data%20Storage")
        pcsx2minusConfig.set("Data%20Storage", "dump_directory", "/userdata/system/configs/pcsx2minus/dump")
        pcsx2minusConfig.set("Data%20Storage", "dump_directory\\default", "true")

        pcsx2minusConfig.set("Data%20Storage", "load_directory", "/userdata/system/configs/pcsx2minus/load")
        pcsx2minusConfig.set("Data%20Storage", "load_directory\\default", "true")

        pcsx2minusConfig.set("Data%20Storage", "nand_directory", "/userdata/system/configs/pcsx2minus/nand")
        pcsx2minusConfig.set("Data%20Storage", "nand_directory\\default", "true")

        pcsx2minusConfig.set("Data%20Storage", "sdmc_directory", "/userdata/system/configs/pcsx2minus/sdmc")
        pcsx2minusConfig.set("Data%20Storage", "sdmc_directory\\default", "true")

        pcsx2minusConfig.set("Data%20Storage", "tas_directory", "/userdata/system/configs/pcsx2minus/tas")
        pcsx2minusConfig.set("Data%20Storage", "tas_directory\\default", "true")

        pcsx2minusConfig.set("Data%20Storage", "use_virtual_sd", "true")
        pcsx2minusConfig.set("Data%20Storage", "use_virtual_sd\\default", "true")

    # Core section
        if not pcsx2minusConfig.has_section("Core"):
            pcsx2minusConfig.add_section("Core")

        # Multicore
        if system.isOptSet('multicore'):
            pcsx2minusConfig.set("Core", "use_multi_core", system.config["multicore"])
            pcsx2minusConfig.set("Core", "use_multi_core\\default", "false")
        else:
            pcsx2minusConfig.set("Core", "use_multi_core", "true")
            pcsx2minusConfig.set("Core", "use_multi_core\\default", "true")

    # Renderer section
        if not pcsx2minusConfig.has_section("Renderer"):
            pcsx2minusConfig.add_section("Renderer")

        # Aspect ratio
        if system.isOptSet('pcsx2minus_ratio'):
            pcsx2minusConfig.set("Renderer", "aspect_ratio", system.config["pcsx2minus_ratio"])
            pcsx2minusConfig.set("Renderer", "aspect_ratio\\default", "false")
        else:
            pcsx2minusConfig.set("Renderer", "aspect_ratio", "0")
            pcsx2minusConfig.set("Renderer", "aspect_ratio\\default", "true")

        # Graphical backend
        if system.isOptSet('pcsx2minus_backend'):
            pcsx2minusConfig.set("Renderer", "backend", system.config["pcsx2minus_backend"])
        else:
            pcsx2minusConfig.set("Renderer", "backend", "0")
        pcsx2minusConfig.set("Renderer", "backend\\default", "false")

        # Async Shader compilation
        if system.isOptSet('async_shaders'):
            pcsx2minusConfig.set("Renderer", "use_asynchronous_shaders", system.config["async_shaders"])
        else:
            pcsx2minusConfig.set("Renderer", "use_asynchronous_shaders", "true")
        pcsx2minusConfig.set("Renderer", "use_asynchronous_shaders\\default", "false")

        # Assembly shaders
        if system.isOptSet('shaderbackend'):
            pcsx2minusConfig.set("Renderer", "shader_backend", system.config["shaderbackend"])
            pcsx2minusConfig.set("Renderer", "shader_backend\\default", "false")
        else:
            pcsx2minusConfig.set("Renderer", "shader_backend", "0")
            pcsx2minusConfig.set("Renderer", "shader_backend\\default", "true")

        # Async Gpu Emulation
        if system.isOptSet('async_gpu'):
            pcsx2minusConfig.set("Renderer", "use_asynchronous_gpu_emulation", system.config["async_gpu"])
            pcsx2minusConfig.set("Renderer", "use_asynchronous_gpu_emulation\\default", "false")
        else:
            pcsx2minusConfig.set("Renderer", "use_asynchronous_gpu_emulation", "true")
            pcsx2minusConfig.set("Renderer", "use_asynchronous_gpu_emulation\\default", "true")

        # NVDEC Emulation
        if system.isOptSet('nvdec_emu'):
            pcsx2minusConfig.set("Renderer", "nvdec_emulation", system.config["nvdec_emu"])
            pcsx2minusConfig.set("Renderer", "nvdec_emulation\\default", "false")
        else:
            pcsx2minusConfig.set("Renderer", "nvdec_emulation", "2")
            pcsx2minusConfig.set("Renderer", "nvdec_emulation\\default", "true")

        # Gpu Accuracy
        if system.isOptSet('gpuaccuracy'):
            pcsx2minusConfig.set("Renderer", "gpu_accuracy", system.config["gpuaccuracy"])
        else:
            pcsx2minusConfig.set("Renderer", "gpu_accuracy", "0")
        pcsx2minusConfig.set("Renderer", "gpu_accuracy\\default", "false")

        # Vsync
        if system.isOptSet('vsync'):
            pcsx2minusConfig.set("Renderer", "use_vsync", system.config["vsync"])
        else:
            pcsx2minusConfig.set("Renderer", "use_vsync", "false")
        pcsx2minusConfig.set("Renderer", "use_vsync\\default", "false")

        # Gpu cache garbage collection
        if system.isOptSet('gpu_cache_gc'):
            pcsx2minusConfig.set("Renderer", "use_caches_gc", system.config["gpu_cache_gc"])
        else:
            pcsx2minusConfig.set("Renderer", "use_caches_gc", "false")
        pcsx2minusConfig.set("Renderer", "use_caches_gc\\default", "false")

        # Max anisotropy
        if system.isOptSet('anisotropy'):
            pcsx2minusConfig.set("Renderer", "max_anisotropy", system.config["anisotropy"])
            pcsx2minusConfig.set("Renderer", "max_anisotropy\\default", "false")
        else:
            pcsx2minusConfig.set("Renderer", "max_anisotropy", "0")
            pcsx2minusConfig.set("Renderer", "max_anisotropy\\default", "true")

        # Resolution scaler
        if system.isOptSet('resolution_scale'):
            pcsx2minusConfig.set("Renderer", "resolution_setup", system.config["resolution_scale"])
            pcsx2minusConfig.set("Renderer", "resolution_setup\\default", "false")
        else:
            pcsx2minusConfig.set("Renderer", "resolution_setup", "2")
            pcsx2minusConfig.set("Renderer", "resolution_setup\\default", "true")

        # Scaling filter
        if system.isOptSet('scale_filter'):
            pcsx2minusConfig.set("Renderer", "scaling_filter", system.config["scale_filter"])
            pcsx2minusConfig.set("Renderer", "scaling_filter\\default", "false")
        else:
            pcsx2minusConfig.set("Renderer", "scaling_filter", "1")
            pcsx2minusConfig.set("Renderer", "scaling_filter\\default", "true")

        # Anti aliasing method
        if system.isOptSet('aliasing_method'):
            pcsx2minusConfig.set("Renderer", "anti_aliasing", system.config["aliasing_method"])
            pcsx2minusConfig.set("Renderer", "anti_aliasing\\default", "false")
        else:
            pcsx2minusConfig.set("Renderer", "anti_aliasing", "0")
            pcsx2minusConfig.set("Renderer", "anti_aliasing\\default", "true")

    # Cpu Section
        if not pcsx2minusConfig.has_section("Cpu"):
            pcsx2minusConfig.add_section("Cpu")

        # Cpu Accuracy
        if system.isOptSet('cpuaccuracy'):
            pcsx2minusConfig.set("Cpu", "cpu_accuracy", system.config["cpuaccuracy"])
            pcsx2minusConfig.set("Cpu", "cpu_accuracy\\default", "false")
        else:
            pcsx2minusConfig.set("Cpu", "cpu_accuracy", "0")
            pcsx2minusConfig.set("Cpu", "cpu_accuracy\\default", "true")

    # System section
        if not pcsx2minusConfig.has_section("System"):
            pcsx2minusConfig.add_section("System")

        # Language
        if system.isOptSet('language'):
            pcsx2minusConfig.set("System", "language_index", system.config["language"])
            pcsx2minusConfig.set("System", "language_index\\default", "false")
        else:
            pcsx2minusConfig.set("System", "language_index", "1")
            pcsx2minusConfig.set("System", "language_index\\default", "true")

        # Region
        if system.isOptSet('region'):
            pcsx2minusConfig.set("System", "region_index", system.config["region"])
            pcsx2minusConfig.set("System", "region_index\\default", "false")
        else:
            pcsx2minusConfig.set("System", "region_index", "1")
            pcsx2minusConfig.set("System", "region_index\\default", "true")

    # controls section
        if not pcsx2minusConfig.has_section("Controls"):
            pcsx2minusConfig.add_section("Controls")

        # Dock Mode
        if system.isOptSet('dock_mode'):
            pcsx2minusConfig.set("Controls", "use_docked_mode", system.config["dock_mode"])
            pcsx2minusConfig.set("Controls", "use_docked_mode\\default", "false")
        else:
            pcsx2minusConfig.set("Controls", "use_docked_mode", "true")
            pcsx2minusConfig.set("Controls", "use_docked_mode\\default", "true")


        if ((system.isOptSet('pcsx2minus_auto_controller_config') and not (system.config["pcsx2minus_auto_controller_config"] == "0")) or not system.isOptSet('pcsx2minus_auto_controller_config')):
            # Player 1 Pad Type
            if system.isOptSet('p1_pad'):
                pcsx2minusConfig.set("Controls", "player_0_type", system.config["p1_pad"])
            else:
                pcsx2minusConfig.set("Controls", "player_0_type", "0")
            pcsx2minusConfig.set("Controls", "player_0_type\default", "false")

            # Player 2 Pad Type
            if system.isOptSet('p2_pad'):
                pcsx2minusConfig.set("Controls", "player_1_type", system.config["p2_pad"])
            else:
                pcsx2minusConfig.set("Controls", "player_1_type", "0")
            
            # Player 3 Pad Type
            if system.isOptSet('p3_pad'):
                pcsx2minusConfig.set("Controls", "player_2_type", system.config["p3_pad"])
            else:
                pcsx2minusConfig.set("Controls", "player_2_type", "0")

            # Player 4 Pad Type
            if system.isOptSet('p4_pad'):
                pcsx2minusConfig.set("Controls", "player_3_type", system.config["p4_pad"])
            else:
                pcsx2minusConfig.set("Controls", "player_3_type", "0")

            
            pcsx2minusConfig.set("Controls", "player_1_type\default", "false")

            pcsx2minusConfig.set("Controls", "vibration_enabled", "true")
            pcsx2minusConfig.set("Controls", "vibration_enabled\\default", "true")

            guidstoreplace_ds4 = ["050000004c050000c405000000783f00","050000004c050000c4050000fffe3f00","050000004c050000c4050000ffff3f00","050000004c050000cc090000fffe3f00","050000004c050000cc090000ffff3f00","30303839663330346632363232623138","31326235383662333266633463653332","34613139376634626133336530386430","37626233336235343937333961353732","38393161636261653636653532386639","63313733393535663339656564343962","63393662363836383439353064663939","65366465656364636137653363376531","66613532303965383534396638613230","050000004c050000cc090000df070000","050000004c050000cc090000df870001","050000004c050000cc090000ff070000","030000004c050000a00b000011010000","030000004c050000a00b000011810000","030000004c050000c405000011010000","030000004c050000c405000011810000","030000004c050000cc09000000010000","030000004c050000cc09000011010000","030000004c050000cc09000011810000","03000000c01100000140000011010000","050000004c050000c405000000010000","050000004c050000c405000000810000","050000004c050000c405000001800000","050000004c050000cc09000000010000","050000004c050000cc09000000810000","050000004c050000cc09000001800000","030000004c050000a00b000000010000","030000004c050000c405000000000000","030000004c050000c405000000010000","03000000120c00000807000000000000","03000000120c0000111e000000000000","03000000120c0000121e000000000000","03000000120c0000130e000000000000","03000000120c0000150e000000000000","03000000120c0000180e000000000000","03000000120c0000181e000000000000","03000000120c0000191e000000000000","03000000120c00001e0e000000000000","03000000120c0000a957000000000000","03000000120c0000aa57000000000000","03000000120c0000f21c000000000000","03000000120c0000f31c000000000000","03000000120c0000f41c000000000000","03000000120c0000f51c000000000000","03000000120c0000f70e000000000000","03000000120e0000120c000000000000","03000000160e0000120c000000000000","030000001a1e0000120c000000000000","030000004c050000a00b000000000000","030000004c050000cc09000000000000","35643031303033326130316330353564","31373231336561636235613666323035","536f6e7920496e746572616374697665","576972656c65737320436f6e74726f6c","050000004c050000cc090000ff870001","050000004c050000cc090000ff876d01","31663838336334393132303338353963"]
            guidstoreplace_ds5_wireless = ["32633532643734376632656664383733","37363764353731323963323639666565","61303162353165316365336436343139","050000004c050000e60c0000df870000","050000004c050000e60c000000810000","030000004c050000e60c000000010000","050000004c050000e60c0000fffe3f00","030000004c050000e60c000000000000","050000004c050000e60c000000010000","030000004c050000e60c000011010000","32346465346533616263386539323932","050000004c050000e60c0000ff870000"]
            guidstoreplace_ds5_wired = ["030000004c050000e60c000011810000"]
            guidstoreplace_xbox = ["050000005e040000fd02000030110000"]
            guidstoreplace_steam = ["03000000de2800000512000010010000"]
            guidstoreplace_steam2 = ["03000000de2800000512000011010000"]

            cguid = [0 for x in range(10)]
            lastplayer = 0
            for index in playersControllers :
                controller = playersControllers[index]
                portnumber = cguid.count(controller.guid)
                controllernumber = str(int(controller.player) - 1)
                cguid[int(controllernumber)] = controller.guid
                inputguid = controller.guid
                #DS4 GUIDs from https://github.com/gabomdq/SDL_GameControllerDB/blob/master/gamecontrollerdb.txt
                if controller.guid in guidstoreplace_ds4:
                    inputguid = "030000004c050000cc09000000006800"
                #DS5 GUIDs from https://github.com/gabomdq/SDL_GameControllerDB/blob/master/gamecontrollerdb.txt
                if controller.guid in guidstoreplace_ds5_wireless:
                    inputguid = "030000004c050000e60c000000006800"
                if controller.guid in guidstoreplace_ds5_wired:
                    inputguid = "030000004c050000e60c000000016800"
                if controller.guid in guidstoreplace_xbox:
                    inputguid = "050000005e040000fd02000030110000"
                #DS5 corrections
                if ((controller.guid in guidstoreplace_ds5_wireless) or (controller.guid in guidstoreplace_ds4) or (controller.guid in guidstoreplace_ds5_wired)) :
                    #button_a="engine:sdl,port:0,guid:030000004c050000e60c000000006800,button:1"
                    for x in pcsx2minusDSButtons:
                        pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_" + x, '"engine:sdl,port:{},guid:{},button:{}"'.format(portnumber,inputguid,pcsx2minusDSButtons[x]))
                    for x in pcsx2minusDSAxis:
                        if(x == "button_zl" or x == "button_zr"):
                            pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_" + x, '"engine:sdl,invert:+,port:{},guid:{},axis:{},threshold:0.500000"'.format(portnumber,inputguid,pcsx2minusDSAxis[x]))
                        else:
                            pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_" + x, '"engine:sdl,port:{},guid:{},axis_x:{},offset_x:-0.011750,axis_y:{},offset_y:-0.027467,invert_x:+,invert_y:+,deadzone:0.150000,range:0.950000"'.format(portnumber,inputguid,pcsx2minusDSAxis[x],pcsx2minusDSAxis[x]+1))
                    pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_motionleft", '"engine:sdl,motion:0,port:{},guid:{}"'.format(portnumber,inputguid))
                    pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_motionright", '"engine:sdl,motion:0,port:{},guid:{}"'.format(portnumber,inputguid))
                elif (controller.guid in guidstoreplace_steam) :
                    #button_a="engine:sdl,port:0,guid:030000004c050000e60c000000006800,button:1"
                    for x in pcsx2minusSCButtons:
                        pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_" + x, '"engine:sdl,port:{},guid:{},button:{}"'.format(portnumber,inputguid,pcsx2minusSCButtons[x]))
                    for x in pcsx2minusSCAxis:
                        if(x == "button_zl" or x == "button_zr"):
                            pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_" + x, '"engine:sdl,invert:+,port:{},guid:{},axis:{},threshold:0.500000"'.format(portnumber,inputguid,pcsx2minusSCAxis[x]))
                        else:
                            pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_" + x, '"engine:sdl,port:{},guid:{},axis_x:{},offset_x:-0.011750,axis_y:{},offset_y:-0.027467,invert_x:+,invert_y:+,deadzone:0.150000,range:0.950000"'.format(portnumber,inputguid,pcsx2minusSCAxis[x],pcsx2minusSCAxis[x]+1))
                    pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_motionleft", '"[empty]"')
                    pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_motionright", '"[empty]"')
                    #pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_motionleft", '"engine:sdl,motion:0,port:{},guid:{}"'.format(portnumber,inputguid))
                    #pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_motionright", '"engine:sdl,motion:0,port:{},guid:{}"'.format(portnumber,inputguid))
                elif (controller.guid in guidstoreplace_steam2) :
                    #button_a="engine:sdl,port:0,guid:030000004c050000e60c000000006800,button:1"
                    for x in pcsx2minusSCButtons2:
                        pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_" + x, '"engine:sdl,port:{},guid:{},button:{}"'.format(portnumber,inputguid,pcsx2minusSCButtons2[x]))
                    for x in pcsx2minusSCAxis2:
                        if(x == "button_zl" or x == "button_zr"):
                            pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_" + x, '"engine:sdl,invert:+,port:{},guid:{},axis:{},threshold:0.500000"'.format(portnumber,inputguid,pcsx2minusSCAxis2[x]))
                        else:
                            pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_" + x, '"engine:sdl,port:{},guid:{},axis_x:{},offset_x:-0.011750,axis_y:{},offset_y:-0.027467,invert_x:+,invert_y:+,deadzone:0.150000,range:0.950000"'.format(portnumber,inputguid,pcsx2minusSCAxis2[x],pcsx2minusSCAxis2[x]+1))
                    pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_motionleft", '"[empty]"')
                    pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_motionright", '"[empty]"')
                    #pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_motionleft", '"engine:sdl,motion:0,port:{},guid:{}"'.format(portnumber,inputguid))
                    #pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_motionright", '"engine:sdl,motion:0,port:{},guid:{}"'.format(portnumber,inputguid))
                else:
                    for x in pcsx2minusButtons:
                        pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_" + x, '"{}"'.format(PCSX2MINUSGenerator.setButton(pcsx2minusButtons[x], inputguid, controller.inputs,portnumber)))
                    for x in pcsx2minusAxis:
                        pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_" + x, '"{}"'.format(PCSX2MINUSGenerator.setAxis(pcsx2minusAxis[x], inputguid, controller.inputs, portnumber)))
                    pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_motionleft", '[empty]')
                    pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_motionright", '[empty]')

                
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_connected", "true")
                if (controllernumber == "0"):
                    pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_connected\default", "true")
                else:
                    pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_connected\default", "false")                    
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_type", "0")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_type\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_vibration_enabled", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_vibration_enabled\\default", "true")
                lastplayer = int(controllernumber)
            lastplayer = lastplayer + 1
            eslog.debug("Last Player {}".format(lastplayer))
            for y in range(lastplayer, 9):
                controllernumber = str(y)
                eslog.debug("Setting Controller: {}".format(controllernumber))
                for x in pcsx2minusButtons:
                    pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_" + x, '""')
                for x in pcsx2minusDSAxis:
                    pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_" + x, '""')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_a", '"toggle:0,code:67,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_a\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_b", '"toggle:0,code:88,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_b\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_ddown", '"toggle:0,code:16777237,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_ddown\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_dleft", '"toggle:0,code:16777234,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_dleft\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_dright", '"toggle:0,code:16777236,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_dright\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_dup", '"toggle:0,code:16777235,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_dup\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_home", '"toggle:0,code:0,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_home\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_l", '"toggle:0,code:81,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_l\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_lstick", '"toggle:0,code:70,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_lstick\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_minus", '"toggle:0,code:78,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_minus\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_plus", '"toggle:0,code:77,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_plus\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_r", '"toggle:0,code:69,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_r\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_rstick", '"toggle:0,code:71,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_rstick\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_screenshot", '"toggle:0,code:0,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_screenshot\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_sl", '"toggle:0,code:81,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_sl\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_sr", '"toggle:0,code:69,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_sr\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_x", '"toggle:0,code:86,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_x\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_y", '"toggle:0,code:90,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_y\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_zl", '"toggle:0,code:82,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_zl\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_zr", '"toggle:0,code:84,engine:keyboard"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_button_zr\\default", "true")

                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_lstick", '"modifier_scale:0.500000,modifier:toggle$00$1code$016777248$1engine$0keyboard,right:toggle$00$1code$068$1engine$0keyboard,left:toggle$00$1code$065$1engine$0keyboard,down:toggle$00$1code$083$1engine$0keyboard,up:toggle$00$1code$087$1engine$0keyboard,engine:analog_from_button"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_lstick\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_rstick", '"modifier_scale:0.500000,modifier:toggle$00$1code$00$1engine$0keyboard,right:toggle$00$1code$076$1engine$0keyboard,left:toggle$00$1code$074$1engine$0keyboard,down:toggle$00$1code$075$1engine$0keyboard,up:toggle$00$1code$073$1engine$0keyboard,engine:analog_from_button"')
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_rstick\\default", "true")


                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_connected", "false")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_connected\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_type", "0")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_type\\default", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_vibration_enabled", "true")
                pcsx2minusConfig.set("Controls", "player_" + controllernumber + "_vibration_enabled\\default", "true")


    # telemetry section
        if not pcsx2minusConfig.has_section("WebService"):
            pcsx2minusConfig.add_section("WebService") 
        pcsx2minusConfig.set("WebService", "enable_telemetry", "false")
        pcsx2minusConfig.set("WebService", "enable_telemetry\\default", "false") 
        
        
    # Services section
        if not pcsx2minusConfig.has_section("Services"):
            pcsx2minusConfig.add_section("Services")
        pcsx2minusConfig.set("Services", "bcat_backend", "none")
        pcsx2minusConfig.set("Services", "bcat_backend\\default", "none") 

        ### update the configuration file
        if not os.path.exists(os.path.dirname(pcsx2minusConfigFile)):
            os.makedirs(os.path.dirname(pcsx2minusConfigFile))
        with open(pcsx2minusConfigFile, 'w') as configfile:
            pcsx2minusConfig.write(configfile)

        with open(beforepcsx2minusConfigFile, 'w') as configfile:
            pcsx2minusConfig.write(configfile)

    @staticmethod
    def setButton(key, padGuid, padInputs,controllernumber):

        # it would be better to pass the joystick num instead of the guid because 2 joysticks may have the same guid
        if key in padInputs:
            input = padInputs[key]

            if input.type == "button":
                return ("engine:sdl,button:{},guid:{},port:{}").format(input.id, padGuid, controllernumber)
            elif input.type == "hat":
                return ("engine:sdl,hat:{},direction:{},guid:{},port:{}").format(input.id, PCSX2MINUSGenerator.hatdirectionvalue(input.value), padGuid, controllernumber)
            elif input.type == "axis":
                # untested, need to configure an axis as button / triggers buttons to be tested too
                return ("engine:sdl,threshold:{},axis:{},guid:{},port:{},invert:{}").format(0.5, input.id, padGuid, controllernumber, "+")
                

    @staticmethod
    def setAxis(key, padGuid, padInputs,controllernumber):
        inputx = -1
        inputy = -1

        if key == "joystick1":
            try:
                inputx = padInputs["joystick1left"]
            except:
                inputx = ["0"]
        elif key == "joystick2":
            try:
                inputx = padInputs["joystick2left"]
            except:
                inputx = ["0"]

        if key == "joystick1":
            try:
                inputy = padInputs["joystick1up"]
            except:
                inputy = ["0"]
        elif key == "joystick2":
            try:
                inputy = padInputs["joystick2up"]
            except:
                inputy = ["0"]

        try:
            return ("engine:sdl,range:1.000000,deadzone:0.100000,invert_y:+,invert_x:+,offset_y:-0.000000,axis_y:{},offset_x:-0.000000,axis_x:{},guid:{},port:{}").format(inputy.id, inputx.id, padGuid, controllernumber)
        except:
            return ("0")

    @staticmethod
    def hatdirectionvalue(value):
        if int(value) == 1:
            return "up"
        if int(value) == 4:
            return "down"
        if int(value) == 2:
            return "right"
        if int(value) == 8:
            return "left"
        return "unknown"