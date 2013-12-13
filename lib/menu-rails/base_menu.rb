module MenuRails

  module BaseMenu

    def display_for_controller(tmp_controller)
      old_controller = @controller
      @controller    = tmp_controller
      block_result   = yield
      @controller    = old_controller

      block_result
    end

    def controller
      raise 'Controller not valid if not displaying menu' if @controller.nil?

      @controller
    end

  end

end