class MemberProfilePdf < Prawn::Document
  TERM_WIDTHS = [20, 150, 200, 202]
  HEADING_WIDTHS = [80, 492]
  HEADING_CONTENT_WIDTHS = [130, 362]
  def initialize(member, view_context)
    super(margin: 20, page_size: [612, 936], page_layout: :portrait)
    @member = member
    @avatar = ActiveStorage::Blob.service.send(:path_for, @member.avatar.key)
    @terms = @member.terms.order(:start_of_term)
    @ordinances = @member.authored_ordinances.order(:number)
    @resolutions = @member.authored_resolutions.order(:number)
    @salary_adjustment = @member.current_salary_adjustment
    @step_increment = @member.current_step_increment
    @ord_table_widths = @ordinances.count > 100 ? [40, 100, 432] : [20, 100, 452]
    @res_table_widths = @resolutions.count > 100 ? [40, 100, 432] : [20, 100, 452]
    @view_context = view_context
    heading
    basic_info_table
    terms_table
    authored_ordinances_table
    authored_resolutions_table
    salary_table
  end

  def price(number)
    @view_context.number_to_currency(number, :unit => "Php ")
  end

  def heading
    text "PROVINCIAL LOCAL GOVERNMENT UNIT - IFUGAO", align: :right, size: 8
    stroke_horizontal_rule
    move_down 5
    text "MEMBER PROFILE", align: :center, size: 14, style: :bold
    stroke_horizontal_rule
  end

  def basic_info_table
    move_down 4
    table([[{image: @avatar, :image_width => 80}, basic_info_data]], cell_style: { size: 10, font: "Helvetica", :padding => [1,4,1,4]}, column_widths: HEADING_WIDTHS) do
      cells.borders = []
    end
    draw_horizontal_line
  end

  def basic_info_data
    make_table([["NAME: ", @member.full_name.upcase]] + 
    [["POSITION: ", @member.current_position.to_s]] + 
    [["PARTY: ", @member.current_party.to_s]] + 
    [["APPOINTMENT STATUS: ", @member.current_appointment_status.to_s]] +
    [["LATEST TERM: ", @member.current_term_in_years]], cell_style: { size: 10, font: "Helvetica", :padding => [1,4,1,4]}, column_widths: HEADING_CONTENT_WIDTHS) do
      cells.borders = []
      column(1).font_style = :bold
    end
  end

  def terms_table
    move_down 8
    text "Terms", align: :left, size: 13, style: :bold
    move_down 2
    header = [["", "TERM PERIOD", "POSITION", "PARTY"]]
    table(header, :cell_style => {size: 9, :padding => [2, 4, 2, 4]}, column_widths: TERM_WIDTHS) do
      cells.borders = [:top]
      row(0).font_style = :bold
    end
    stroke_horizontal_rule
    n = 0
    terms_data = @terms.map { |t| [n = n ? n+1 : 1, t.in_year_range, t.position.to_s, t.political_party.to_s]}
    table_data = [*terms_data]
    table(table_data, cell_style: { size: 9, font: "Helvetica", inline_format: true, :padding => [2, 4, 2, 4]}, column_widths: TERM_WIDTHS) do
      cells.borders = [:top]
      column(2).align = :justify
    end
    draw_horizontal_line
  end

  def authored_ordinances_table
    move_down 8
    text "Authored Ordinances", align: :left, size: 13, style: :bold
    move_down 2
    if @ordinances.blank?
      text "No Data", align: :center, size: 12, style: :bold
    else
      header = [["", "ORDINANCE #", "TITLE"]]
      table(header, :cell_style => {size: 9, :padding => [2, 4, 2, 4]}, column_widths: @ord_table_widths) do
            cells.borders = [:top]
            row(0).font_style = :bold
            column(1).align = :center
          end
      stroke_horizontal_rule
      n = 0
      ordinances_data = @ordinances.map { |o| [n = n ? n+1 : 1, "PO# #{o.number}\nApproved: #{o.date_approved}", o.title]}
      table_data = [*ordinances_data]
      table(table_data, cell_style: { size: 9, font: "Helvetica", inline_format: true, :padding => [2, 4, 2, 4]}, column_widths: @ord_table_widths) do
        cells.borders = [:top]
        column(2).align = :justify
      end
    end
    draw_horizontal_line
  end

  def authored_resolutions_table
    move_down 8
    text "Authored Resolutions", align: :left, size: 13, style: :bold
    move_down 2
    if @resolutions.blank?
      text "No Data", align: :center, size: 12, style: :bold
    else    
      header = [["", "RESOLUTION #", "TITLE"]]
      table(header, :cell_style => {size: 9, :padding => [2, 4, 2, 4]}, column_widths: @res_table_widths) do
            cells.borders = [:top]
            row(0).font_style = :bold
            column(1).align = :center
          end
      stroke_horizontal_rule
      n = 0
      resolutions_data = @resolutions.map { |o| [n = n ? n+1 : 1, "RES# #{o.number}\nApproved: #{o.date_approved}", o.title]}
      table_data = [*resolutions_data]
      table(table_data, cell_style: { size: 9, font: "Helvetica", inline_format: true, :padding => [2, 4, 2, 4]}, column_widths: @res_table_widths) do
        cells.borders = [:top]
        column(2).align = :justify
      end
    end
    draw_horizontal_line
  end

  def salary_table
    move_down 8
    text "Salary Details", align: :left, size: 13, style: :bold
    move_down 2
    if @salary_adjustment.blank? && @step_increment.blank?
      text "No Data", align: :center, size: 12, style: :bold
    else
      table([[salary_adjustment_table, step_increment_table]], cell_style: { size: 10, font: "Helvetica", :padding => [1,4,1,4]}, column_widths: [286,286]) do
        cells.borders = []
      end
    end
    draw_horizontal_line
  end

  def salary_adjustment_table
    if @salary_adjustment.present?
      make_table([["Salary Adjustment", ""]] +
      [["Term: ", @salary_adjustment.term.in_year_range]] + 
      [["Dated At: ", @salary_adjustment.dated_at.strftime("%B %e, %Y")]] + 
      [["Effectivity Date: ", @salary_adjustment.effectivity_date.strftime("%B %e, %Y")]] + 
      [["Basic Salary: ", price(@salary_adjustment.monthly_salary)]] +
      [["Adjustment: ", price(@salary_adjustment.adjustment)]] +
      [["Adjusted Salary: ", price(@salary_adjustment.adjusted_salary)]], cell_style: { size: 11, font: "Helvetica", :padding => [1,4,1,4]}, column_widths: [130,152]) do
        cells.borders = [:top]
        column(1).font_style = :bold
        row(0).font_style = :bold
      end
    end
  end

  def step_increment_table
    if @step_increment.present?
      make_table([["Step Increment", ""]] +
      [["Term: ", @step_increment.term.in_year_range]] + 
      [["Dated At: ", @step_increment.dated_at.strftime("%B %e, %Y")]] + 
      [["Effectivity Date: ", @step_increment.effectivity_date.strftime("%B %e, %Y")]] + 
      [["Basic Salary: ", price(@step_increment.salary_prior_to_adjustment)]] +
      [["Adjustment: ", price(@step_increment.salary_adjustment)]] +
      [["Adjusted Salary: ", price(@step_increment.adjusted_salary)]], cell_style: { size: 11, font: "Helvetica", :padding => [1,4,1,4]}, column_widths: [130,152]) do
        cells.borders = [:top]
        column(1).font_style = :bold
        row(0).font_style = :bold
      end
    end
  end

  def draw_horizontal_line
    move_down 10
    stroke_horizontal_rule
  end
end