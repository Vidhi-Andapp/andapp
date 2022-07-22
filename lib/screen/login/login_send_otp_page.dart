import 'dart:async';
import 'package:andapp/common/string_utils.dart';
import 'package:andapp/screen/login/login_send_otp_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:andapp/common/image_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../common/app_theme.dart';
import '../../common/pink_border_button.dart';
import 'custom_speed_dial.dart';
import 'package:email_validator/email_validator.dart';
/*
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as htmlparser;
import 'package:flutter_html/flutter_html.dart';
*/

class LoginSendOTP extends StatefulWidget {
  const LoginSendOTP({Key? key}) : super(key: key);

  @override
  State<LoginSendOTP> createState() => _LoginSendOTPState();
}

class _LoginSendOTPState extends State<LoginSendOTP> with TickerProviderStateMixin {
  final LoginSendOTPBloc bloc = LoginSendOTPBloc();

  final sendOTPKey = GlobalKey<FormState>(),
      updateMobNoKey = GlobalKey<FormState>(),updateMOTPKey = GlobalKey<FormState>();
  bool isOtpEnabled = false;
  String? htmlTerms = """<!DOCTYPE html>
<html>
<head>
</head>
<body>

<div class="modal-body">
    <b> Service Agreement with POSP</b>

    <p>This Agreement (hereinafter referred to as /‘the Agreement/’, which term shall include the annexures, attachments, addendums and schedules described therein/ appended/ attached thereto) is made on this	day of November, 2020 (“effective date”)</p>

    <b>Between:</b>

    <p>
        IAND Insurance Broker Private Limited, a company incorporated under the provisions of Companies Act,  2013  and  having  its  principal place of business at 1106, 11th floor, D & C Dynasty building, C G Road, Near Sardar Patel Stadium Cross roads, Navrangpura, Ahmedabad-380009 (herein after referred to as “the Company”, which expression shall, unless it be repugnant to the context or meaning thereof, be deemed to mean and include its legal representatives, assigns, administrators, representative-in-interest and executors etc.) of the First Part;
    </p>

    And

    Shri ______________________ Point of Sales Person (hereinafter referred to as POSP), (General Insurance) having its place of residence and/or work at_________________________________ which expression shall, unless repugnant or contrary to the context, include its representative-in-interest and permitted assigns etc.) of the Other Part;

    <p>
        The Company and POSP may hereinafter collectively be referred to as ‘Parties’ and  individually as ‘Party’.
    </p>

    <p>
        Whereas, Company is a Direct Broker registered by IRDAI vide Registration No.727 valid w.e.f. 26/8/2020 to 25/8/2023 and renewable thereafter from to time.
    </p>

    <p>
        Whereas, Company wishes to contract with POSP to solicit the Insurance products, as may be specified by IRDAI from time to time, on the terms and conditions provided for herein.
    </p>

    <p>
        Whereas, POSP desires to enter into an Agreement with Company for the solicitation of such Insurance product/products.
    </p>

    <p>
        Whereas, the Company appoints the POSP for the purpose of marketing, selling and after sales service of Insurance policies on behalf of the Company. The Company reserves the right to approve or disapprove the contracting of any such POSP. The Company and the POSP expressly agree that the POSP is not an employee of the Company and shall be considered an independent contractor for the purposes of this agreement. The POSP shall not be reimbursed of any expenses incurred under this agreement and shall supply his or her own work place,  use his or her own supplies  and set his or her own work hours, all at no cost to the Company AND.
    </p>

    <p>
        WHEREAS – The POSP person shall be atleast 10th pass or attain any other qualification IRDAI may prescribe from time to time. Should have underwent applicable mandatory training and successfully completed exam as applicable under the IRDAI guidelines on Point of Sales Person – Life, Non-Life &amp; Health Insurers/ IRDAI guidelines on Point of Sales Person –Life.
    </p>

    <p>
        NOW THIS AGREEMENT WITNESSETH AND IT IS HEREBY AGREED BY AND BETWEEN THE PARTIES HERETO AS FOLLOWS:
    </p>

    <p>
        1.	DEFINITIONS
    </p>

    <p>
        It is expressly understood by and between the parties hereto that the terms mentioned in this Agreement shall have the same meaning as ascribed to it under the Regulations.
    </p>

    <p>
        b)	“Authority” or “IRDAI” means the Insurance Regulatory and Development Authority established under the provisions of Section 3 of the Insurance Regulatory and Development Authority Act, 1999 (41 of1999).
    </p>
    <p>
        c)	“Insurance Broker” – as defined in Regulation 2(1)(k) of Insurance Regulatory and Development Authority (Insurance Company) Regulations,2013.
    </p>

    <p>
        d)	“Insurer” – means -, as defined in Section 2 (9) of Insurance Act,1938.
    </p>

    <p>
        e)	“Website” – shall mean _________________and the ___________ Mobile App, which is owned and maintained by the Insurance Broker.
    </p>

    <p>
        f)	All words and expressions used and not defined in these Guidelines but defined in the Insurance Act, 1938 (4 of 1938), the Insurance Regulatory and Development Authority Act, 1999 (41 of 199), or in any of the Regulations / Guidelines made thereunder including but not limited to the IRDAI Guidelines on Point of Sales Person – Non-Life &amp; Health Insurers, Guidelines on Point of Sales Person –Life Insurers, Insurance Regulatory and Development Authority (Insurance Broker) Regulations, 2013 shall have the meanings respectively assigned to them in those Acts or Regulations / Guidelines including their respective amendments thereof.
    </p>

    <b>  Interpretation:</b>

    <p>
        All definitions mentioned in the IRDAI Guidelines and regulations for Insurance Brokers and POSP shall apply mutatis mutandis to the terms of this Agreement.
    </p>

    <p>
        In this Agreement, headings are for convenience only and do not affect the interpretation of this Agreement, and, unless the context otherwise requires:
    </p>

    <p>
        (a)	words in the singular include the plural and vice versa;
    </p>

    <p>
        (b)	words importing a gender include any gender;
    </p>

    <p>
        (c)	a reference to a Clause is to a clause of this Agreement;
    </p>

    <p>
        (d)	all words and expressions used and not defined in this Agreement but defined in the Insurance Act 1938, the Insurance Regulatory and Development Authority Act, 1999 or any of the Regulations made there under shall have the meanings respectively assigned to them in those Acts or Regulations.
    </p>

    <p>
        2.	 SCOPE OF SERVICES AND COMPENSATION:
    </p>

    <p>
        The Parties agree that POSP shall perform the activities as allowed and envisaged under the IRDAI prescribed guidelines from time to time.
    </p>

    <p>
        The Company agrees to make payment and/or remuneration to the POSP fees for the services and discharge of his/her functions obligations to be rendered by the POSP as specified in Annexure B attached hereto.
    </p>

    <p>
        3.	TERM AND TERMINATION:
    </p>

    <p>
        a)	This Agreement shall come into effect from the Effective Date,	 (Date of Clearing the Exam) and shall remain in force and effect for a period of three (3) years or expiry of the License whichever is earlier and is subsequently extendable by a block of 3 years by the mutual consent of the two parties.
    </p>

    <p>
        b)	The Parties can renew or enter into another agreement or may on or prior to the expiry of the term aforementioned, mutually agree in writing to extend this Agreement for a further period/s of such duration as agreed by the Parties subject to renewal of registration.
    </p>

    <p>
        c)	Notwithstanding anything contained in this Agreement to the contrary or notwithstanding any separate written communication, either Party may terminate this Agreement at any time by providing one (1) month's prior notice in writing to the other Party during the validity of the Agreement.
    </p>

    <p>
        d)	This Agreement will terminate automatically upon the occurrence of any of the following events by POSP and upon such occurrence the parties shall be obligated to make only those payments the right to which accrued to the date of termination:
    </p>


    <p>
        e)	Conviction under felony by POSP;
    </p>

    <p>
        •	Misappropriation (or failure to remit) any funds or property due the Company from POSP;
    </p>
    <p>
        •	Determination that POSP is not in compliance with Company underwriting guidelines or the terms of this Agreement and POSP has failed to correct the problem within 10 days of the Company providing written notice of same;
    </p>
    <p>
        •	In the event of fraud or material breach of any of the conditions or provisions of this Agreement on the part of either party, the other party may terminate the Agreement immediately upon written notice.
    </p>
    <p>
        •	Fails to comply with directions of IAND Insurance Broker Private Limited.
    </p>
    <p>
        •	Furnish wrong information or conceals the information or fails to disclose the material facts of the policy to the policyholder.
    </p>
    <p>
        •	Fails to resolve complaints, unless the circumstances are beyond his/her control, emanating from the business procured by him/her and persons he deals with
    </p>
    <p>
        •	Indulges in inducement in cash or kind with client or any other insurance intermediary/agent/insurer.
    </p>
    <p>
        •	Fails to pay any penalty levied on his/her account.
    </p>
    <p>
        •	Fails to carry out his/her obligations as prescribed in the agreement and in the provisions of: Act/regulations/circulars or guidelines by IRDAI from time to time.
    </p>
    <p>
        •	Acts in a manner prejudice to the interest of the company or the client
    </p>
    <p>
        •	Acts in a manner that amounts to diverting funds of his/her Group/Affiliates or associates rather than engaging in the activity of soliciting and servicing insurance business
    </p>
    <p>
        •	Is found guilty of fraud or is charged or convicted in any criminal act.
    </p>
    <p>
        •	Any loss to the Company because of the act by POSP, Company shall not be liable for payment of any compensation/loss/claim made by the third party against the Company.
    </p>

    <p>
        f)	Agreement shall automatically terminate if the POSP acquires a license as or becomes related to, an insurance company, insurance agent, corporate agent, a micro- insurance agent, TPA, Surveyor, Referral partner or loss assessor. In addition to the aforementioned, on a contravention of this condition by the POSP, he/she shall be liable to indemnity by the company as per claim made on him/her.
    </p>

    <p>
        4.	REPRESENTATIONS AND WARRANTIES:
    </p>

    <p>
        a)	POSP represents and warrants to the Company that:
    </p>

    <p>
        (i)	He/she has the necessary qualification power or authority and the legal right to conduct the business/provide unprejudiced services to the company in respect of all or any of the functions.
    </p>
    <p>
        (ii)	POSP represents and warrants that he/she has never been convicted of any crime involving moral turpitude and is not disqualified as per section 42D(5) of the Insurance Act and remains Fit and Proper as per the format enclosed herewith as Annexure-2;
    </p>
    <p>
        (iii)	He/she has the necessary power or authority and the legal right to execute, deliver and perform this Agreement;
    </p>
    <p>
        (iv)		He/she shall comply with all applicable regulatory and other legal requirements to this Agreement.
    </p>
    <p>
        (v)	POSP will diligently and to the best of its ability ensure that the facts set forth by any applicant/prospect in any application it solicits are true and correct.
    </p>
    <p>
        b) The Company hereby represents and warrants to -that:
    </p>

    <p>
        (i)	 It has obtained all the necessary approvals, permits and authorizations  internally or otherwise, as may be required to engage in the business as envisaged under and to enter into this Agreement;
    </p>

    <p>
        (ii)	It has fulfilled all the criteria provided under the applicable Regulations but not limited to the IRDAI Guidelines on Point of Sales Person for: Life Insurers, Non-Life &amp; Health Insurers, Guidelines on Point of Sales Person –Life Insurers, Insurance Regulatory and Development Authority (Insurance Broker) Regulations, 2013 to act as POSP
    </p>

    <p>
        (iii)	It shall comply with all applicable regulatory and other legal requirements to this Agreement.
    </p>

    <p>
        5.	OBLIGATIONS OF POSP:
    </p>

    <p>
        The POSP hereby agrees, covenants and undertakes with  as follows:
    </p>
    <p>
        •	POSP will comply with all laws and regulations which relate to this Agreement and shall indemnify and hold the Company harmless for its failure to do so. POSP shall maintain in good standing, at its own cost, licenses required by all applicable statutes and regulations.
    </p>

    <p>
        •	POSP may not solicit any business except: mentioned in Schedule "A" (Please add all those policies/products Authorized by IRDAI from time to time.)
    </p>

    <p>
        •	POSP will comply with the Company's rules and regulations relating to the Soliciting the insurance business. As a material part of the consideration for the making of this Agreement by the Company, POSP agrees that there will be made no representations whatsoever with respect to the nature or scope of the benefits of the Policies sold except through and by means of the written material either prepared and furnished to POSP for that purpose by the Company or approved in writing by the Company  prior to its use. POSP shall have no authority and will not make any oral or written alteration, modification, or waiver of any of the terms or conditions of any Policy whatsoever.
    </p>

    <p>
        •	POSP will conduct itself so as not to affect adversely the business, good standing, and reputation of the Company.
    </p>

    <p>
        •	POSP agrees not to employ or make use of any advertisement in which the Company's (or its affiliate's) name or its registered trademarks are employed without the prior written approval and consent of the Company. Upon request of POSP during the term of this Agreement, the Company shall make available for POSP's use, standard visiting cards, and other material. POSP may add, at POSP's expense, to the standard advertising only its business name, business address, POSP number and telephone number, as provided for in the advertising. No deletions or changes in the advertising copy are permissible.
    </p>

    <p>
        •	POSP shall act solely as an independent contractor, of-course subject to the control and guidance of the company, and as such, shall have control on: all matters, its time and effort in the placement of the Policies offered hereunder. Nothing herein contained shall be construed to create the relationship of employer and employee between POSP and Company.
    </p>

    <p>
        •	POSP shall indemnify and hold the Company and its officers, POSPs and employees harmless from all expenses, costs, causes of action, claims, demands, liabilities and damages, including reasonable attorney's fees, resulting from or growing out of any unauthorized act or transaction or any negligent act, omission or transaction by POSP or employees of POSP.
    </p>

    <p>
        •	Change of Address: POSP shall notify Company in writing of any change of address and/or communication at least thirty (30) days prior to the effective date of such change.
    </p>

    <p>
        •	Collection of Premiums: POSP shall have no authority, without written permission of Company, to collect or provide receipt for premiums to customer and shall assist the client for compliance of section 64VB of the Insurance Act1938. In no circumstances he/she shall collect the amount in cash from the customer/client, if he/she is found doing so the agreement shall be terminated for the fault of POSP and the Company shall be entitled to take recourse as mentioned in the said Agreement.
    </p>

    <p>
        •	Other Expenses: POSP shall have no claim or shall not be entitled to reimbursement for any expenses.
    </p>

    <p>
        •	POSP shall, on behalf of the Company, collect premiums as per IRDAI norms. All premiums collected on business produced by the POSP hereunder shall be submitted to the Company within same day of receipt by POSP.
    </p>

    <p>
        •	To faithfully perform all duties required hereunder, to cooperate with the Company in all matters pertaining to the issuance of policies, cancellations, claims and to promote the best interest of the Company.\
    </p>

    <p>
        •	POSP will be bound not to work for any other intermediaries or the Insurance companies. Whatever work he does in the insurance space, POSP is bound to do through Company only.
    </p>

    <p>
        •	POSP will ensure the compliance of FIU and obtains KYC
    </p>
    <p>
        •	POSP shall not do any claim consultancy and any such opportunity that comes in this area. He shall be further obliged to bring to the notice of the company for its further doing the needful in a professional manner.
    </p>

    <p>
        •	Any financial penalty levied by the IRDAI, if it is based on the violations and noncompliance by the POSP shall be borne by him/her. Similarly if suspension, cancellation or withdrawal of license of the company is based on breaches/noncompliance on the account of POSP, the POSP shall indemnify the consequential losses to the company.
    </p>

    <p>
        •	The POSP shall be duty bound to cooperate with the officers of IRDAI for the purpose of inspection as may be required by IRDAI inspectors or investigating authority from time to time.
    </p>

    <p>
        •	He shall will carry on its business pertaining to POSP products lawfully and diligently , and in compliance with all applicable laws, rules and regulations including but not limited to the IRDAI Guidelines on Point of Sales Person – Non-Life &amp; Health Insurers, Guidelines on Point of Sales Person –Life Insurers.
    </p>

    <p>
        It shall comply with all the provisions of the Insurance Act 1938, IRDA Act, 1999 and rules and regulations framed thereunder and such other directions issued and/or amended by the Authority from time to time.
    </p>

    <p>
        6.	OBLIGATIONS OF THE COMPANY
    </p>

    <p>
        •	It shall maintain records of all information obtained through the POSP, the details of the policies sold out of such information thus obtained and other functions/activities performed by POSP as a part of his/her engagement/appointment with the company shall furnish such records or information as required by IRDAI in relation to this agreement as and when required.
    </p>
    <p>
        •	It shall vary depending upon the specific product being sold by POSP. For all products, the Company will provide brochures and proposal forms. The Company will deliver to the customer all insurance policies and related correspondence or similar documents, in accordance with Company procedures.
    </p>
    <p>
        •	It shall respond in a reasonable and timely manner to inquiries and questions about the product.
    </p>
    <p>
        •	It shall maintain reasonable accounting, administrative, and statistical records in accordance with prudent standards of insurance record keeping, including premium, sale or effective date, and any other records needed to verify coverage, pay claims, or underwrite the company insurance products, of any insured participant covered under the policies.
    </p>

    <p>
        7.	RESERVATION OF RIGHTS
    </p>

    <p>
        The Company reserves the right to reject any and all applications for its Policies submitted by POSP if they are not found to be of the order of merit required by the customer or the company or the Insurance Company.
    </p>

    <p>
        The Company reserves the right to discontinue writing or offering any of the Policies which become subject to this Agreement upon sixty (60) days notice to POSP (or the number of days required by law in the POSP's state of domicile).
    </p>

    <p>
        The Company shall share with the POSP information relating to the products as agreed with its insurance partner and as agreed between the parties from time to time.
    </p>

    <p>
        8.	PRIVACY POLICY
    </p>

    <p>
        POSP confirms and undertakes the he will not violate privacy covenants and in case of any breach of privacy the POSP shall be solely responsible for losses arising out of the same.
    </p>

    <p>
        POSP shall ensure that there are proper encryption and security measures to

        prevent any hacking into the information/data pertaining to transactions contemplated under this Agreement. POSP shall adhere to the appropriate security norms including but not limited to the Information Technology (Reasonable Security Practices and Procedures and Sensitive Personal Data or Information) Rules, 2011 as amended from time to time.

        POSP shall not share any information of the clients and the Company with others without permission of the client and the company
    </p>





    <p>
        9.	 INTELLECTUAL PROPERTY RIGHTS ANDBRANDING:
    </p>

    <p>
        The intellectual property rights (in the nature of trademark or copyright or any other right) in the brand name, product names, logos, designs, colour schemes, names, marks, designs, drawings, colour, artistic work / manner etc (hereafter collectively referred as "Marks") as may be allowed by - to be used by Company shall vest exclusively and at all times in - and POSP agrees and undertakes not to set up an adverse claim at any time either during the period of this Agreement or at any time thereafter. The POSP also agrees and undertakes that it shall not allow the usage of Marks by any other third party nor he shall use the same accept as provided in this Agreement.
    </p>

    <p>
        10.	       CONFIDENTIALITY:
    </p>
    <p>
        a.	Both parties recognize, accept and agree that all tangible and intangible information obtained or disclosed to each other and/or its personnel/representatives, including all details, documents, data, records, reports, systems, papers, notices, statements, business information and practices and trade secrets (all of which are collectively referred to as “Confidential Information”) shall be treated as confidential and both Parties agree and undertake that the same will be kept secret and will not be disclosed, save as provided below, in whole or in part to any person/s and/or used and/or be allowed to be used for any purpose other than as may be necessary for the due performance of obligations hereunder, except with written authorization from other party.
    </p>

    <p>
        b.	POSP agrees and undertakes that he shall hold all Confidential Information in confidence and in particular shall:
    </p>

    <p>
        i.	not use or permit or enable any person to use any of the Confidential Information in any manner.
    </p>
    <p>
        ii.	not disclose or divulge any Confidential Information to any person return all and any Confidential Information which may be in his/her possession/custody within three years of termination/ expiry of this Agreement including the fees/commission/ remuneration earned by him/her.
    </p>

    <p>
        c.	The obligation of confidentiality as above shall not apply to any information which is:
    </p>
    <p>
        (i)	in the public domain through no fault of the receiving party,
    </p>
    <p>
        (ii)	rightfully received from a third party without any obligation of confidentiality,
    </p>
    <p>
        (iii)	rightfully known to the receiving party without any limitation on use or disclosure prior to its receipt from the disclosing party,
    </p>
    <p>
        (iv)	independently developed by the receiving party,
    </p>
    <p>
        (v)	generally made available to third parties without any restriction on disclosure,
    </p>
    <p>
        (vi)	communicated in response to a valid order by a court or other governmental body, as otherwise required by law, or as necessary to establish the rights of either party under this Agreement.
    </p>

    <p>
        d.	Obligations under this clause to the extent provided shall continue to apply even after the termination or expiry of this Agreement. In case of any breach of this provision by either party, POSP undertakes to indemnify for losses caused due to such breach.
    </p>

    <p>
        11.	  INDEMNITY:
    </p>

    <p>
        POSP agrees to indemnify and keep indemnified and hold harmless at all times its directors and officers from and against any and all losses, claims, actions, proceedings, damages (including reasonable legal and lawyer’s fees) which may be incurred by - on account of (a) negligence or misconduct on the part of the POSP (b) due to breach any terms and conditions of this Agreement (c) for breach of any intellectual property rights of, or of any third party which commences an action or makes a claim against - and such breach is attributable to the acts of omission / commission by Insurance Company (d) any loss caused to - due to breach of Confidentiality.
    </p>

    <p>
        12.	LAW AND ARBITRATION:
    </p>

    <p>
        a.	The provisions of this Agreement shall be governed by, and construed in accordance with Indian law.
    </p>

    <p>
        b.	Any dispute, controversy or claims arising out of or relating to this Agreement or the breach, termination or invalidity thereof, shall be settled by Sole Arbitrator in the arbitration proceedings in accordance with the provisions of the Arbitration and Conciliation Act, 1996. Following provisions shall be adhered to for any such arbitral proceedings:
    </p>

    <p>
        (i)	The arbitral tribunal shall be composed of a sole arbitrator who shall be finalized by the Company who has the experience in the Insurance field for atleast 10 years.
    </p>

    <p>
        (ii)	The place of arbitration shall be Ahmedabad and any award whether interim or final, shall be made, and shall be deemed for all purposes between the Parties to be made, in Ahmedabad.
    </p>

    <p>
        (iii)	 The arbitral procedure shall be conducted in the English language   and any award	or awards shall be rendered in English. The procedural law of the arbitration shall be Indian law.
    </p>

    <p>
        (iv)	The award of the arbitrator shall be final and conclusive and binding upon the Parties, and the Parties shall be entitled (but not obliged) to enter judgement thereon in any one or more of the courts having jurisdiction. The Parties further agree (to the maximum extent possible and allowed to them) that such enforcement shall be subject to the provisions of the Arbitration and Conciliation Act,1996.
    </p>

    <p>
        (v)		The rights and obligations of the Parties under, or pursuant to, this Clause, including the arbitration Agreement in this Clause, shall be governed by and be subject to Indian law.
    </p>

    <p>
        13. MISCELLANEOUS
    </p>

    <p>
        (A) Amendments; No Waivers
    </p>

    <p>
        (i)	Any provision of this AGREEMENT may be amended or waived if, and only if such amendment or waiver is in writing and signed, in the case of an amendment by each Party or in the case of a waiver, by the Party against whom the waiver is to be effective.
    </p>

    <p>
        (ii)	No failure or delay by any Party in exercising any right, power or privilege hereunder shall operate as a waiver thereof nor shall any single or partial exercise of any other right, power or privilege. The rights and remedies herein provided shall be cumulative and not exclusive of any rights or remedies provided bylaw.
    </p>

    <p>
        (B)	       Entire Agreement; No Third Party Rights
    </p>

    <p>
        This AGREEMENT constitutes the entire Agreement between the Parties with respect to the subject matter hereof. No representations, inducements, promises, understandings, conditions, indemnities or warranties not set forth herein have been made or relied upon by any Party hereto.

        Neither this AGREEMENT nor any provision hereof is intended to confer upon any Person other than the Parties to this AGREEMENT any rights or remedies hereunder.
    </p>
    <p>
        (C)	       Further Assurances
    </p>
    <p>
        In connection with this AGREEMENT, as well as all transactions contemplated by this AGREEMENT, POSP agrees to execute and deliver such additional documents and to perform such additional actions as may be necessary, appropriate or reasonably requested to carry out or evidence the transactions contemplated hereby.
    </p>
    <p>
        (D)        Severability
    </p>
    <p>
        The invalidity or unenforceability of any provisions of this AGREEMENT in any jurisdiction shall not effect the validity, legality or enforceability of the remainder of this AGREEMENT in such jurisdiction or the validity, legality or enforceability of this AGREEMENT, including any such provision, in any other jurisdiction, it being intended that all rights and obligations of the Parties hereunder shall be enforceable to the fullest extent permitted bylaw.
    </p>
    <p>
        (E)        Counterparts
    </p>
    <p>
        This Agreement may be executed simultaneously in duplicate each of which will be deemed an original, but all of which will constitute one and the same instrument.
    </p>
    <p>
        (F)	         Communication &amp; Notices
    </p>
    <p>
        Any notice or other communication given pursuant to this Agreement must be in writing and (a) delivered personally, (b) sent by facsimile or other similar facsimile transmission or sent by registered mail, postage prepaid, as follows:
    </p>
    <p>
        If to (POSP):
    </p>
    _______________________
    <p></p>
    <p>
        _______________________
    </p>
    <p>
        If to the Broker (Company):
    </p><p>
</p><p>
    IAND Insurance Broker Private Limited,
</p>

    <p>
        10, Swati Apartment, Jagabhai Park, Rambag, Maninagar, Ahmedabad, Gujarat  380008
    </p>

    <p>
        Attn:	Compliance Officer
    </p>


    <p>
        IN WITNESS WHEREOF the Parties have caused these present to be executed on the day and year first hereinabovewritten:
    </p>

    __________________________
    Director
    IAND Insurance Broker Private Limited,









    ___________________________
    Name
    POSP

    <p>
        Schedule - A
    </p>

    <p>
        The POSP is allowed to offer ONLINE PRODUCTS of (the insurance company’s name etc)- with whom the company has entered into an agreement for sale through the web portals of the - subject to the following conditions:
    </p>

    <p>
        1.	The POSP is permitted only to offer the following ranges of products online or any other products range as approved from time to time by the Authority:—
    </p>

    <p>
        Non Life:
    </p>
    <p>
        a.	Motor Comprehensive Insurance Package Policy for two wheeler, private car        and commercial vehicles
    </p>
    <p>
        b.	Third Party liability(Act Only) policy of Two wheeler private car and commercial vehicles
    </p>
    <p>
        c.	Personal Accident Policy
    </p>
    <p>
        d.	Travel Insurance Policy
    </p>
    <p>
        e.	Home Insurance Policy
    </p>
    <p>
        f.	  Crop Insurance with a sum insured limit of Rs. 1 lakh per acre for all kinds of crops
    </p>
    <p>
        g.	Hospital cash policy where a fixed benefit in the form of cash every day hospitalization with a limit of Rs. 1 lakh per individual
    </p>
    <p>
        h.	Critical illness policy which covers 8-9 critical illness with a maximum sum insured limit of Rs.3. Lakh per individual
    </p><p>
</p><p>
    i.	   Any other Policy specifically approved by the Authority
</p>

    <p>
        Annexure II    Remuneration
    </p>
    <p>
        1.	The POSP shall be paid or contract to be paid by way of remuneration (including royalty administration charges or travel charges or reasonable reimbursement of expenses incurred by POSP in performance of his/her duties/functions/obligations or in any other form), an amount not exceeding the limits as specified/notified by the Authority in the circulars/regulations issued in this behalf and as amended from time to time.
    </p>

    <p>
        2.	The settlement of accounts by  in respect of remuneration of POSP shall be done on a monthly basis and it must be ensured that there is no cross settlement of outstanding balances.
    </p>

    <p>  3.	That none of the payments made by the company to the POSP constitute any legal relationship of employee and employer in the usual and general form of contract of employment and thereby POSP shall not be entitled to claim any dues such as: PF, Contribution towards medical benefits (including ESI Contribution/membership) leave encashment, ESOPS etc.,   </p>
</div>

</form>
</body>
</html>
""";

  // dom.Document? document;

  Future<void> loadHtmlFromAssets() async {
    htmlTerms = await decodeStringFromAssets(
        AssetImages.htmlTerms);
    //document = htmlparser.parse(htmlTerms);
  }

  @override
  void initState() {
    super.initState();
    loadHtmlFromAssets();
    bloc.getToken(context);
  }

  Future<String> decodeStringFromAssets(String path) async {
    ByteData byteData = await PlatformAssetBundle().load(path);
    String htmlString = String.fromCharCodes(byteData.buffer.asUint8List());
    return htmlString;
  }

  @override
  Widget build(BuildContext context) {
    final _appTheme = AppTheme.of(context);
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(),
        //backgroundColor: const Color(0xff222222),
        body: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 50.0),
                              child: Center(child: SvgPicture.asset(
                                SvgImages.imageLoginLight, height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 2.5,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 2.5,))
                          ),

                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Column(
                                children: [
                                  Form(
                                    key: sendOTPKey,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 32),
                                          child: TextFormField(
                                            controller: bloc.mobNo,
                                            decoration: InputDecoration(
                                                labelText: "Mobile Number",
                                                labelStyle: TextStyle(
                                                    color: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        ?.color),
                                                fillColor: Colors.white,
                                                enabledBorder: Theme
                                                    .of(context)
                                                    .inputDecorationTheme
                                                    .border,
                                                focusedBorder: Theme
                                                    .of(context)
                                                    .inputDecorationTheme
                                                    .border
                                            ),
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                            ],
                                            validator: (val) {
                                              String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                              RegExp regExp = RegExp(pattern);
                                              if (val == null || val.isEmpty) {
                                                return "Please enter mobile number";
                                              }
                                              else if (
                                              val.length != 10 ||
                                                  !regExp.hasMatch(val)) {
                                                return "Please enter valid mobile number";
                                              }
                                              else {
                                                return null;
                                              }
                                            },
                                            maxLength: 10,
                                            keyboardType: TextInputType.phone,
                                            style: const TextStyle(
                                              fontFamily: "Poppins",
                                              //color: Colors.white
                                            ),
                                          ),
                                        ),

                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 12.0),
                                            child: PinkBorderButton(
                                              isEnabled: true,
                                              content: StringUtils.otp,
                                              onPressed: () async {
                                                final form = sendOTPKey
                                                    .currentState;
                                                if (form?.validate() ?? false) {
                                                  form?.save();
                                                  bloc.sendOTP(context);
                                                }
                                              },)
                                        ),
                                      ],
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      bloc.email.clear();
                                      bloc.otp.clear();
                                      isOtpEnabled = false;
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: _appTheme
                                              .greyBgColor,
                                          shape: const RoundedRectangleBorder( // <-- SEE HERE
                                            borderRadius: BorderRadius
                                                .vertical(
                                              top: Radius.circular(16.0),
                                            ),
                                          ),
                                          builder: (context) {
                                            return Column(
                                              mainAxisSize: MainAxisSize
                                                  .min,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .stretch,
                                              children: <Widget>[
                                                Container(
                                                    height: 50,
                                                    width: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width,
                                                    padding: const EdgeInsets
                                                        .all(16),
                                                    decoration: ShapeDecoration(
                                                        shape: const RoundedRectangleBorder( // <-- SEE HERE
                                                          borderRadius: BorderRadius
                                                              .vertical(
                                                            top: Radius
                                                                .circular(
                                                                16.0),
                                                          ),
                                                        ),
                                                        color: _appTheme
                                                            .primaryColor),
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    child: Row(
                                                      children: [
                                                        const Expanded(
                                                          child: Text(
                                                              'Update Mobile Number',
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight
                                                                      .bold)),
                                                        ),

                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Icon(
                                                              Icons.clear),
                                                        ),
                                                      ],
                                                    )),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .all(16.0),
                                                  child: Text(
                                                    StringUtils
                                                        .updateMobileTitle,
                                                    style: TextStyle(
                                                        color: Theme
                                                            .of(context)
                                                            .primaryColor,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight
                                                            .normal),),
                                                ),
                                                Form(
                                                  key:updateMobNoKey,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(
                                                        16, 8, 16, 8),
                                                    child: TextFormField(
                                                      controller: bloc.email,
                                                      decoration: InputDecoration(
                                                          labelText: "Email ID",
                                                          hintStyle: TextStyle(
                                                              color: _appTheme
                                                                  .primaryColor,
                                                              fontWeight: FontWeight
                                                                  .bold
                                                            //color: Colors.white
                                                          ),
                                                          labelStyle: TextStyle(
                                                            color: _appTheme
                                                                .primaryColor,
                                                            //fontWeight: FontWeight.w500
                                                            //color: Colors.white
                                                          ),
                                                          suffixIcon: Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical: 8.0,
                                                                horizontal: 12.0),
                                                            child: PinkBorderButton(
                                                              isEnabled: true,
                                                              content: StringUtils
                                                                  .otp,
                                                              onPressed: () async {
                                                                final form = updateMobNoKey
                                                                    .currentState;
                                                                if (form
                                                                    ?.validate() ??
                                                                    false) {
                                                                  form?.save();
                                                                  await bloc
                                                                      .sendOTPUpdateMobile(
                                                                      context)
                                                                      .then((
                                                                      value) {
                                                                    if (bloc
                                                                        .updateMobOtp !=
                                                                        null) {
                                                                      bloc.otp
                                                                          .text =
                                                                      bloc
                                                                          .updateMobOtp!;
                                                                      isOtpEnabled =
                                                                      true;
                                                                    }
                                                                  });
                                                                }
                                                              },),
                                                          ),
                                                          fillColor: Colors
                                                              .white,
                                                          filled: true,
                                                          enabledBorder: Theme
                                                              .of(context)
                                                              .inputDecorationTheme
                                                              .border,
                                                          focusedBorder: Theme
                                                              .of(context)
                                                              .inputDecorationTheme
                                                              .border
                                                      ),
                                                      validator: (val) {
                                                        // ignore: prefer_is_empty
                                                        if (val == null ||
                                                            val.isEmpty) {
                                                          return "Please enter email Id";
                                                        }
                                                        else if (!EmailValidator
                                                            .validate(
                                                            val, true)) {
                                                          return "Please enter valid email Id";
                                                        }
                                                        else {
                                                          return null;
                                                        }
                                                      },

                                                      keyboardType: TextInputType
                                                          .emailAddress,
                                                      style: TextStyle(
                                                          color: _appTheme
                                                              .speedDialLabelBgDT
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Form(
                                                  key:updateMOTPKey,
                                                  child: Padding(
                                                    padding: EdgeInsets
                                                        .fromLTRB(
                                                        16, 8, 16, MediaQuery
                                                        .of(context)
                                                        .viewInsets
                                                        .bottom),
                                                    child: TextFormField(
                                                      controller: bloc.otp,
                                                      decoration: InputDecoration(
                                                          labelText: StringUtils
                                                              .otp,
                                                          labelStyle: const TextStyle(
                                                              color: Colors
                                                                  .white),
                                                          suffixIcon: Padding(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                vertical: 8.0,
                                                                horizontal: 12.0),
                                                            child: PinkBorderButton(
                                                              isEnabled: true,
                                                              content: "Verify",
                                                              onPressed: () async {
                                                                final form = updateMOTPKey
                                                                    .currentState;
                                                                if (form
                                                                    ?.validate() ??
                                                                    false) {
                                                                  form?.save();
                                                                  if (bloc.otp
                                                                      .text ==
                                                                      bloc
                                                                          .updateMobOtp!) {
                                                                    await bloc
                                                                        .updateMobile(
                                                                        context)
                                                                        .then((
                                                                        value) {

                                                                    }
                                                                    );
                                                                  }
                                                                }
                                                              },),
                                                          ),
                                                          fillColor: _appTheme
                                                              .speedDialLabelBgDT,
                                                          filled: true,
                                                          enabled: isOtpEnabled,
                                                          enabledBorder: Theme
                                                              .of(context)
                                                              .inputDecorationTheme
                                                              .border,
                                                          focusedBorder: Theme
                                                              .of(context)
                                                              .inputDecorationTheme
                                                              .border
                                                      ),
                                                      validator: (val) {
                                                        // ignore: prefer_is_empty
                                                        if (val?.length ==
                                                            0 &&
                                                            val?.length !=
                                                                5) {
                                                          return "Please enter valid OTP";
                                                        }
                                                        else {
                                                          return null;
                                                        }
                                                      },
                                                      keyboardType: TextInputType
                                                          .phone,
                                                      style: const TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .fromLTRB(
                                                      16.0, 16, 16, 32),
                                                  child: Text(
                                                    StringUtils
                                                        .updateMobileContent,
                                                    textAlign: TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                        color: Theme
                                                            .of(context)
                                                            .primaryColor,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight
                                                            .normal),),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: const Text(
                                      "Update Mobile Number",
                                      style: TextStyle(fontSize: 14),),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: RichText(
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(
                                      text: "By continuing, you agree to our",
                                      style: TextStyle(
                                          color: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyText2
                                              ?.color)),
                                  TextSpan(text: " Terms and conditions",
                                      style: TextStyle(
                                          color: _appTheme.primaryColor),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          /*String htmlTerms = await decodeStringFromAssets(
                                            AssetImages.htmlTerms);*/
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              shape: const RoundedRectangleBorder( // <-- SEE HERE
                                                borderRadius: BorderRadius
                                                    .vertical(
                                                  top: Radius.circular(16.0),
                                                ),
                                              ),

                                              builder: (context) {
                                                return DraggableScrollableSheet(
                                                  expand: false,
                                                  initialChildSize: 0.5,
                                                  maxChildSize: 0.75,
                                                  builder: (_, controller) =>
                                                      SingleChildScrollView(
                                                        controller: controller,
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize
                                                          .min,
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .stretch,
                                                          children: <Widget>[
                                                            Container(
                                                                height: 50,
                                                                width: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .width,
                                                                padding: const EdgeInsets
                                                                    .all(16),
                                                                decoration: ShapeDecoration(
                                                                    shape: const RoundedRectangleBorder( // <-- SEE HERE
                                                                      borderRadius: BorderRadius
                                                                          .vertical(
                                                                        top: Radius
                                                                            .circular(
                                                                            16.0),
                                                                      ),
                                                                    ),
                                                                    color: _appTheme
                                                                        .primaryColor),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Row(
                                                                  children: [
                                                                    const Expanded(
                                                                      child: Text(
                                                                          StringUtils
                                                                              .termsConditions,
                                                                          style: TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight
                                                                                  .bold)),
                                                                    ),

                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Icon(
                                                                          Icons
                                                                              .clear),
                                                                    ),
                                                                  ],
                                                                )),
                                                            Padding(
                                                              padding: const EdgeInsets.all(16.0),
                                                              child: HtmlWidget(
                                                                // the first parameter (`html`) is required
                                                                htmlTerms ??
                                                                    "<html><head></head><body></body></html>",

                                                                // turn on selectable if required (it's disabled by default)
                                                                isSelectable: true,

                                                                // these callbacks are called when a complicated element is loading
                                                                // or failed to render allowing the app to render progress indicator
                                                                // and fallback widget
                                                                onErrorBuilder: (
                                                                    context,
                                                                    element,
                                                                    error) =>
                                                                    Text(
                                                                        '$element error: $error'),
                                                              /*  onLoadingBuilder: (
                                                                    context,
                                                                    element,
                                                                    loadingProgress) => AppComponentBase.getInstance()?.showProgressDialog(true),
*/
                                                                // this callback will be triggered when user taps a link
                                                                //onTapUrl: (url) => print('tapped $url'),

                                                                // select the render mode for HTML body
                                                                // by default, a simple `Column` is rendered
                                                                // consider using `ListView` or `SliverList` for better performance
                                                                renderMode: RenderMode
                                                                    .column,

                                                                // set the default styling for text
                                                                textStyle: const TextStyle(
                                                                    fontSize: 14,color: Colors.black45),

                                                                // turn on `webView` if you need IFRAME support (it's disabled by default)
                                                                //webView: true,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                );
                                              });
                                        }),
                                ])),
                          )
                        ]
                    ),
                  ),
                ),
              );
            }
        ),
        floatingActionButtonLocation: const CustomFloatingActionButtonLocation(
            0,
            -24),
        floatingActionButton:
        const CustomSpeedDial(),
        /*StreamBuilder(
          stream: _bloc.mainStream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Container();
          },
        ),*/
      ),
    );
  }
}

class CustomFloatingActionButtonLocation implements FloatingActionButtonLocation {
  final double x;
  final double y;
  const CustomFloatingActionButtonLocation(this.x, this.y);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(x, y);

  }
}
