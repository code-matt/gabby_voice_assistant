class API_ai_voice_controller
  attr_accessor :currenrtVoiceRequest, :ApiAI, :request, :ApiAI_instance
  @@currentVoiceRequest = nil
  @@ApiAI_instance = nil

  def initialize
    error = Pointer.new(:object)
    sessionInstance = AVAudioSession.sharedInstance
    sessionInstance.setCategory(AVAudioSessionCategoryPlayAndRecord, error: error)
    sessionInstance.setActive(true, error: error)

    configuration = AIDefaultConfiguration.alloc.init
    configuration.clientAccessToken = App::ENV['API_AI_AGENT_TOKEN']
    configuration.subscriptionKey = App::ENV['API_AI_SUBSCRIPTION_KEY']

    @ApiAI = ApiAI.alloc.init
    @ApiAI.setConfiguration(configuration)
    @@ApiAI_instance = @ApiAI
    @tts = MVSpeechSynthesizer.sharedSyntheSize
    MVSpeechSynthesizer.sharedSyntheSize.setURate(0.4)
    MVSpeechSynthesizer.sharedSyntheSize.setPitchMultiplier(3)
    @tts.speechString = "I am awake now sir!"
    @tts.startRead
  end

  def start_listening
    @request = @ApiAI.voiceRequest
    @request.setUseVADForAutoCommit(false)
    @request.completionBlock = lambda do
      process_response(@request)
    end
    @@currentVoiceRequest = @request
    @ApiAI.enqueue(@request)
  end

  def stop_listening
    @request.commitVoice
  end

  def process_response(request)
    mp request.response
    Dispatch::Queue.main.async do
      rmq(:gabby_container_style).style{ |st| st.frame = {l: 115, t: 160} }
      HomeScreen.class_variable_get("@@screen").gabby_flash_return
    end
    if request.response.key?("result")
      if(request.response[:result].key?("parameters"))
        if(request.response[:result][:parameters].key?("route_param"))
          tell_gabby(request.response)
        end
      end
      if(!request.response[:result][:metadata].key?("intentName"))
        @tts.speechString = "Sir, you have not taught me about that yet."
        @tts.startRead
        return false
      end

      speech = @request.response[:result][:speech]
      if speech != ""
        @tts.speechString = speech
        @tts.startRead
      end
    else
      @tts.speechString = "Sir, I am having a problem communitcating with a-p-i a-i"
      @tts.startRead
    end
  end

  def toggle_looping
    if @looping
      @looping = false
    else
      @looping = true
      loop
    end
  end

  def loop
    2.waitSecondsAnd do
      rmq(:root_view).screen.gabby_toggle
      if @looping == true
        loop
      end
    end
  end

  def tell_gabby(response)
    model = "#{response[:result][:parameters][:model]}"
    route_param = "#{response[:result][:parameters][:route_param]}"
    mp "route params: #{route_param}"
    if response[:result][:parameters].key?("#{route_param}")
      param_value = response[:result][:parameters].fetch("#{route_param}")
    end
    param_array = "#{route_param}".split(",")
    url = "http://localhost:6544/#{model}"
    mp "Param array: #{param_array}"
    param_array.each do |param|
      url += "/#{response[:result][:parameters].fetch(param)}"
    end
    mp "Final url: #{url}"
    AFMotion::JSON.get(url) do |result|
      if !result.error
        mp result.object
        if result.object.key?("speech")
          @tts.speechString = result.object[:speech].to_s
          @tts.startRead
        end
      else
        mp result.error.localizedDescription
        # @tts.speechString = "Sir, something went wrong contacting that other part of myself"
        # @tts.startRead
      end

    end
  end
end
