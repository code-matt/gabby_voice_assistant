class HomeScreenStylesheet < ApplicationStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.black
  end

  def gabby_rings_style(st)
    st.alpha = 0
  end

  def invis_gabby_button_style(st)
    st.background_color = rmq.color.clear
    st.frame = ('c1:j11')
  end

  def loop_mode_label_style(st)
    st.frame = {l: 92.5, t: 507, w: 200, h: 28}
    st.text_alignment = :center
    st.color = rmq.color.gabby_purple
    st.font = font.medium
    st.text = 'loop_mode'

    #shadows can be used to fake glow
    st.shadow_color = rmq.color.gabby_pink
    st.shadow_opacity = 0.9;
    st.shadow_offset = [0.5, 1.0]
  end

  def mute_gabby_label_style(st)
    st.frame = {l: 92.5, t: 572, w: 200, h: 28}
    st.text_alignment = :center
    st.color = rmq.color.gabby_purple
    st.font = font.medium
    st.text = 'mute_gabby'
    st.shadow_color = rmq.color.gabby_pink
    st.shadow_opacity = 0.9;
    st.shadow_offset = [0.5, 1.0]
  end

  def start_recording_button_style(st)
    st.frame = 'c7:i8'
    st.background_color = color.tint
    st.text = "Start"
  end

  def stop_recording_button_style(st)
    st.frame = 'd10:i11'
    st.background_color = color.tint
    st.text = "Send"
  end

  def loop_mode_switch_style(st)
    st.frame = {l: 166.7, t: 535.2, w: 51, h: 31}
  end

  def mute_gabby_switch_style(st)
    st.frame = {l: 166.7, t: 601.1, w: 51, h: 31}
  end

  def gabby_container_style(st)
    st.background_color = rmq.color.clear
    # st.frame = {l: -11.2, t: 11.9, w: 233.3, h: 352.4}
    st.frame = {l: 115, t: 160, w: 150, h: 150}
  end

  def gabby_iris_style(st)
    st.frame = {l: 11, t: 43, w: 128, h: 128}
    st.image = image.resource("gabby_iris")  # for logo@2x.png or logo.png
    st.alpha = 0
    st.scale = 1.6
  end

  def gabby_pupil_style(st)
    st.frame = {l: 11, t: 43, w: 128, h: 128}
    st.image = image.resource("gabby_pupil")  # for logo@2x.png or logo.png
    st.alpha = 0
    st.scale = 1.6
  end

  def gabby_dots_style(st)
    st.frame = {l: 11, t: 41, w: 128, h: 128}
    st.image = image.resource("gabby_dots")  # for logo@2x.png or logo.png
    st.alpha = 0
    st.scale = 0.72
  end

  def gabby_portal_style(st)
    st.frame = {l: 100, t: 145, w: 30, h: 30}
    st.image = image.resource("gabby_portal")
    st.scale = 0.01
    st.alpha = 0
    st.shadow_color = rmq.color.gabby_pink
    st.shadow_opacity = 0.9;
    st.shadow_offset = [0.5, 1.0]
  end

  def gabby_top_portal_style(st)
    st.frame = {l: 150, t: 30, w: 30, h: 30}
    st.image = image.resource("gabby_top_portal")
    st.scale = 0.01
    st.alpha = 0
    st.shadow_color = rmq.color.gabby_pink
    st.shadow_opacity = 0.9;
    st.shadow_offset = [0.5, 1.0]
  end

end
