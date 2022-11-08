class StandingMembersPdf < Prawn::Document
  TABLE_WIDTHS = [160, 212, 100, 100]
  # HEADING_WIDTHS = [160,120,70,100, 100]
  def initialize(members, sp_term, year, view_context)
    super(margin: 20, page_size: [612, 1008], page_layout: :portrait)
    @members = members
    @sp_term = sp_term
    @year = year
    @title = "#{@sp_term.number_ordinal} Sangguniang Panlalawigan Standing Members"
    @view_context = view_context
    heading
    display_members_table
  end

  def heading
    text @title.upcase, align: :center, size: 13, style: :bold
    move_down 2
    text @sp_term.in_year_range, align: :center, size: 11, style: :bold
    move_down 10
  end

  def display_members_table
    if @members.blank?
      move_down 10
      text "No data.", align: :center
    else
      move_down 4
      header = [["MEMBER", "POSITION", "PARTY", "CONSECUTIVE TERMS COUNT"]]
      table(header, :cell_style => {size: 9, :padding => [2, 4, 2, 4]}, column_widths: TABLE_WIDTHS) do
        cells.borders = []
        row(0).font_style = :bold
      end
      stroke_horizontal_rule
      header = ["", "", "", ""]
      footer = ["", "", "", ""]
      members_data = @members.map { |m| [m.name_in_honorifics.titleize, m.by_term_position(@year), m.by_term_party(@year).code, m.consecutive_terms_count]}
      table_data = [header, *members_data, footer]
      table(table_data, cell_style: { size: 9, font: "Helvetica", inline_format: true, :padding => [2, 4, 2, 4]}, column_widths: TABLE_WIDTHS) do
        cells.borders = [:top]
        row(0).font_style = :bold
      end
    end
  end
end