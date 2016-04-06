class HomeScreen < PM::Screen
  attr_accessor :ApiAI_instance, :stop_recording
  stylesheet HomeScreenStylesheet
  @@screen = nil

  def on_load
    @@screen = rmq.screen
    @ApiAI_instance = API_ai_voice_controller.new

    ##################
    ###GABBY SOUNDS###
    ##################
    move_sound = AFSoundItem.alloc.initWithLocalResource("gabby_move.wav",atPath:App.resources_path)
    @move_sound_player = AFSoundPlayback.alloc.initWithItem(move_sound)
    @move_sound_player.player.setVolume(3.5)
    return_sound = AFSoundItem.alloc.initWithLocalResource("gabby_return.wav",atPath:App.resources_path)
    @return_sound_player = AFSoundPlayback.alloc.initWithItem(return_sound)
    @return_sound_player.player.setVolume(3.5)
    ##################
    ##################

    rmq.append(UILabel, :loop_mode_label_style)
    @loop_mode_switch = rmq.append(UISwitch, :loop_mode_switch_style).on(:change) do |_|
      @ApiAI_instance.toggle_looping
    end

    rmq.append(UILabel, :mute_gabby_label_style)
    @mute_gabby_switch = rmq.append(UISwitch, :mute_gabby_switch_style).on(:change) do |_|
      mp ";| hi"
    end

    @ring_speed = 1
    @gabby_container = rmq.append(UIView, :gabby_container_style)
    ring_factory(CGRectMake(25, 55, 100, 100),3)
    ring_factory(CGRectMake(42.5, 72.5, 65, 65),5)
    ring_factory(CGRectMake(55, 85, 40, 40),5)
    rmq(CircleProgressBar).tag(:eye_rings)
    @gabby_iris = rmq(:gabby_container_style).append(UIImageView, :gabby_iris_style)
    @gabby_pupil = rmq(:gabby_container_style).append(UIImageView, :gabby_pupil_style)
    @gabby_dots = rmq(:gabby_container_style).append(UIImageView, :gabby_dots_style)

    gabby_custom_fade(@gabby_iris,0.75,3.5)
    gabby_custom_fade(@gabby_pupil,0.75,3.5)
    gabby_custom_fade(rmq(:eye_rings),1,4)
    2.waitSecondsAnd do
      gabby_custom_fade(@gabby_dots,0.75,3)
    end

    gabby_spin_loop
    gabby_spin
    gabby_dots_spin
    gabby_random_motion
    gabby_pupil_roam

    @activate_gabby_button = rmq.append(UIButton, :invis_gabby_button_style).on(:tap) do |_|
      gabby_toggle
    end
  end

  def gabby_toggle
    request = API_ai_voice_controller.class_variable_get("@@currentVoiceRequest")
    if request
      if request.isFinished
        start_recording
        gabby_throb
        @ring_speed = 2
      else
        stop_recording
        @ring_speed = 1
      end
    else
      start_recording
      gabby_throb
      @ring_speed = 2
    end
  end

  def start_recording
    @ApiAI_instance.start_listening
  end

  def stop_recording
    gabby_go_up
    @ApiAI_instance.stop_listening
  end

  def ring_factory(cgrect, width)
    ring = rmq(:gabby_container_style).append(CircleProgressBar.alloc.initWithFrame(cgrect), :gabby_rings_style).get
    gabby_colors = [rmq.color.gabby_pink, rmq.color.gabby_purple]
    ring.hintViewBackgroundColor = rmq.color.clear
    ring.setHintHidden(true);
    ring.setProgressBarProgressColor(gabby_colors.sample)
    ring.setProgressBarTrackColor(rmq.color.clear)
    ring.setProgressBarWidth(width)
    ring.setBackgroundColor(rmq.color.clear)
  end

  #########################
  ####GABBY ANIMATIONS#####
  #########################

  def gabby_pupil_roam
    5.waitSecondsAnd do
      gabby_pupil_roam
      dir = [false,true].sample
      rmq(:gabby_pupil_style).animate(
      duration: 2,
      animations: -> (q) {
        if dir
          q.nudge(l:5, d:5)
        else
          q.nudge(r:5, d:-5)
        end
      },
      completion: -> (did_finish, q) {
        q.animate(
        duration: 3,
        animations: -> (cq) {
          if dir
            cq.nudge(r:5, d:-5)
          else
            cq.nudge(l:5, d:5)
          end
        })
      })
    end
  end

  def gabby_spin_loop
    1.waitSecondsAnd do
      rmq(CircleProgressBar).get.each do |ring|
        ring.setProgress((rand(500..1000)/1000.0), animated: true, duration: 2/@ring_speed)
      end
      gabby_spin_loop
    end
  end

  def gabby_random_motion
    rand(3..5).waitSecondsAnd do
      gabby_random_motion
      rmq(:gabby_container_style).animate(
      duration: rand(3..5),
      animations: -> (q) {
        q.nudge(t:30, l:20)
      },
      completion: -> (did_finish, q) {
        q.animate(
        duration: rand(3..5),
        animations: -> (cq) {
          cq.nudge(t:-30, l:-20)
        })
      })
    end
  end

  def gabby_spin
    rand(3..5).waitSecondsAnd do
      gabby_spin
      rmq(:eye_rings).animate(
      duration: rand(3..5),
      animations: -> (q) {
        q.style {|st| st.rotation = rand(0..360)*@ring_speed}
      },
      completion: -> (did_finish, q) {
        q.animate(
        duration: rand(3..5),
        animations: -> (cq) {
          cq.style {|st| st.rotation = rand(0..360) * @ring_speed}
        })
      })
    end
  end

  def gabby_dots_spin
    rand(3..5).waitSecondsAnd do
      gabby_dots_spin
      rmq(:gabby_dots_style).animate(
      duration: rand(1..2),
      animations: -> (q) {
        q.style {|st| st.rotation = rand(0..360)*@ring_speed}
      },
      completion: -> (did_finish, q) {
        q.animate(
        duration: rand(1..2),
        animations: -> (cq) {
          cq.style {|st| st.rotation = rand(0..360) * @ring_speed}
        })
      })
    end
  end

  #TO_DO
  def gabby_sleep
  end
  #TO_DO
  def gabby_wake
  end

  def gabby_go_up
    top_portal_appear
    rmq(:gabby_container_style).animate(
    duration: 0.3,
    animations: -> (q) {
      @move_sound_player.restart
      @move_sound_player.play
      q.style{|st| st.frame = {t: -300}}
      q.style{|st| st.scale = 0.1}
    },
    completion: -> (did_finish, q) {
      mp "pichoooooooo"
    })
  end

  def gabby_flash_return
    portal_appear
    rmq(:gabby_container_style).animate(
    duration: 1,
    animations: -> (q) {
      @return_sound_player.restart
      @return_sound_player.play
      q.move(centered: :both)
      q.style { |st| st.scale = 1}
    },
    completion: -> (did_finish, t) {
      t.animate(
      duration: 0.4,
      animations: -> (cq) {
        t.style {|st| st.frame = {l: 115, t: 160, w: 150, h: 150}}
      })
      mp "pichoooooooo"
    })
  end

  def portal_appear
    rmq.append(UIImageView,:gabby_portal_style)
    rmq(:gabby_portal_style).animate(
    duration: 0.3,
    animations: -> (q) {
      q.style { |st| st.scale = 4.0}
      q.style { |st| st.alpha = 0.9}
    },
    completion: -> (did_finish, t) {
      t.animate(
      duration: 0.3,
      animations: -> (cq) {
        cq.style {|st| st.alpha = 0}
        cq.style {|st| st.scale = 0.2}
      })
      mp "pichoooooooo"
    })
    1.waitSecondsAnd do
      rmq(:gabby_portal_style).hide.remove
    end
  end

  def top_portal_appear
    rmq.append(UIImageView,:gabby_top_portal_style)
    rmq(:gabby_top_portal_style).animate(
    duration: 0.4,
    animations: -> (q) {
      q.style { |st| st.scale = 4.0}
      q.style { |st| st.alpha = 0.9}
    },
    completion: -> (did_finish, t) {
      t.animate(
      duration: 0.6,
      animations: -> (cq) {
        cq.style {|st| st.alpha = 0}
        cq.style {|st| st.scale = 0.2}
      })
      mp "pichoooooooo"
    })
    1.waitSecondsAnd do
      rmq(:gabby_portal_style).hide.remove
    end
  end

  def gabby_throb
    rmq(:gabby_container_style).animate(
    duration: 0.3,
    animations: -> (q) {
      q.style {|st| st.scale = 1.7}
    },
    completion: -> (did_finish, q) {
      q.animate(
      duration: 0.2,
      animations: -> (cq) {
        cq.style {|st| st.scale = 1}
      })
    })
  end

  def gabby_custom_fade(objects,ending_alpha,duration)
    objects.animate(
    duration: duration,
    animations: -> (q) {
      q.style {|st| st.alpha = ending_alpha}
    },
    completion: -> (did_finish, q) {
      mp "wooooosha"
    })
  end

end
